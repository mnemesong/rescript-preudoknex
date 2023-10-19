open Clarification
open KnexCore
open Belt

module type PrimaryKey = {
  type pk
  type clarification

  let new: unit => option<pk>
  let stringify: pk => string
  let parse: string => option<pk>
  let applyClarification: (knexBuilder, clarification) => knexBuilder
}

module type ColumnName = {
  let columnName: string
}

module type PrimaryKeyUuid = PrimaryKey
  with type pk = string
  and type clarification = stringClarification

module type MakePrimaryKeyUuid = (ColumnName: ColumnName) => PrimaryKeyUuid

module MakePrimaryKeyUuid: MakePrimaryKeyUuid = (ColumnName: ColumnName) => {
  type pk = string
  type clarification = stringClarification

  let new = (): option<pk> => Some(Uuid.V4.make())

  let stringify = (pk: pk): string => pk

  let parse = (str: string): option<pk> => {
    Uuid.validate(str) ? Some(str) : None
  }

  let applyClarification = (knex: knexBuilder, clar: clarification): knexBuilder =>
    applyStringClarification(knex, ColumnName.columnName, clar)
}

module type PrimaryKeyAutoIncrementInt = PrimaryKey
  with type pk = int
  and type clarification = intClarification

module type MakePrimaryKeyAutoIncrementInt = (ColumnName: ColumnName) => PrimaryKeyAutoIncrementInt

module MakePrimaryKeyAutoIncrementInt: MakePrimaryKeyAutoIncrementInt = (
  ColumnName: ColumnName,
) => {
  type pk = int
  type clarification = intClarification

  let new = (): option<pk> => None

  let stringify = (pk: pk): string => Int.toString(pk)

  let parse = (str: string): option<pk> => {
    Int.fromString(str)
  }

  let applyClarification = (knex: knexBuilder, clar: clarification): knexBuilder =>
    applyIntClarification(knex, ColumnName.columnName, clar)
}
