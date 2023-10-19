open Clarification
open KnexCore

type scalarVal

let scalarifyDefault: 'a => scalarVal = %raw(`
function (a) {
  return a;
}
`)

module type ValueType = {
  type value
  type valClarification

  let scalarify: value => scalarVal
  let stringifyVal: value => string
  let buildColumn: (knexTable, string) => unit
}

module type IntValueType = ValueType with type value = int

module IntValueTrait = {
  type value = int
  type valClarification = intClarification

  let scalarify: int => scalarVal = scalarifyDefault

  let stringifyVal: int => string = %raw(`
  function (i) {
    return i.toString();
  }
  `)
}

module IntValueType: IntValueType = {
  include IntValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.integer(colName);
    }
  `)
}

module TinyIntValueType: IntValueType = {
  include IntValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.tinyInt(colName);
    }
  `)
}

module SmallIntValueType: IntValueType = {
  include IntValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.smallInt(colName);
    }
  `)
}

module MediumIntIntValueType: IntValueType = {
  include IntValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.mediumInt(colName);
    }
  `)
}

module BigIntValueType: IntValueType = {
  include IntValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.bigInt(colName);
    }
  `)
}

module type FloatValueType = ValueType with type value = float

module FloatValueTrait = {
  type value = float
  type valClarification = floatClarification

  let scalarify: float => scalarVal = scalarifyDefault

  let stringifyVal: float => string = %raw(`
  function (i) {
    return i.toString();
  }
  `)
}

module FloatValueType: FloatValueType = {
  include FloatValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.float(colName);
    }
  `)
}

module DoubleValueType: FloatValueType = {
  include FloatValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.double(colName);
    }
  `)
}

module type StringValueType = ValueType with type value = string

module StringValueTrait = {
  type value = string
  type valClarification = stringClarification

  let scalarify: string => scalarVal = scalarifyDefault

  let stringifyVal: string => string = %raw(`
  function (i) {
    return i;
  }
  `)
}

module StringValueType: StringValueType = {
  include StringValueTrait

  let buildColumn: (knexTable, string) => unit = %raw(`
    function (table, colName) {
      return table.string(colName);
    }
  `)
}
