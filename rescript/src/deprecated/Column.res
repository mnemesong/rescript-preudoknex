open KnexCore
open PrimaryKey

type tableVal<'pk, 'v> = TableVal(string, string, 'pk, 'v)

module type Column = {
  type value
  type pk
  type valClarification
  type pkClarification

  let columnName: string
  let table: string
  let serializeVal: value => unknown
  let deserializeVal: unknown => value
  let stringifyVal: value => string
  let new: value => tableVal<pk, value>
  let clarify: (knexBuilder, pkClarification, valClarification) => knexBuilder
}

module type MakeColumn = (PrimaryKey: PrimaryKey) =>
(Column with type pk = PrimaryKey.pk and type pkClarification = PrimaryKey.clarification)

module type ValueType = {
  type value
  type valClarification

  let serializeVal: value => unknown
  let deserializeVal: unknown => value
  let stringifyVal: value => string
  let buildColumn: knexTable => unit
}
