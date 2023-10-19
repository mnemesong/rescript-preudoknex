open KnexCore

type rec stringClarification =
  | Any
  | Null
  | Not(stringClarification)
  | And(array<stringClarification>)
  | Or(array<stringClarification>)
  | Eq(string)
  | More(int)
  | Less(int)
  | Between(string, string)
  | In(array<string>)
  | Like(string)
  | ILike(string)

type rec intClarification =
  | Any
  | Null
  | Not(intClarification)
  | And(array<intClarification>)
  | Or(array<intClarification>)
  | Eq(int)
  | More(int)
  | Less(int)
  | In(array<int>)
  | Between(int, int)

type rec floatClarification =
  | Any
  | Null
  | Not(floatClarification)
  | And(array<floatClarification>)
  | Or(array<floatClarification>)
  | More(int)
  | Less(int)
  | Between(int, int)

type rec boolClarification =
  | Any
  | Null
  | Not(boolClarification)
  | And(array<boolClarification>)
  | Or(array<boolClarification>)
  | OnlyTrue
  | OnlyFalse

let applyOnlyTrue: (knexBuilder, string) => knexBuilder = %raw(`
function (knex, colName) {
  return knex.where(colName, true);
}
`)

let applyOnlyFalse: (knexBuilder, string) => knexBuilder = %raw(`
function (knex, colName) {
  return knex.where(colName, false);
}
`)

let applyOnlyNull: (knexBuilder, string) => knexBuilder = %raw(`
function (knex, colName) {
  return knex.whereNull(colName);
}
`)

let applyEq: (knexBuilder, string, 'a) => knexBuilder = %raw(`
function (knex, colName, val) {
  return knex.where(colName, val);
}
`)

let applyMore: (knexBuilder, string, 'a) => knexBuilder = %raw(`
function (knex, colName, val) {
  return knex.where(colName, '>', val);
}
`)

let applyLess: (knexBuilder, string, 'a) => knexBuilder = %raw(`
function (knex, colName, val) {
  return knex.where(colName, '<', val);
}
`)

let applyBetween: (knexBuilder, string, 'a, 'b) => knexBuilder = %raw(`
function (knex, colName, v1, v2) {
  return knex.whereBetween(colName, [v1, v2]);
}
`)

let applyIn: (knexBuilder, string, array<'a>) => knexBuilder = %raw(`
function (knex, colName, vals) {
  return knex.whereIn(colName, vals);
}
`)

let applyLike: (knexBuilder, string, string) => knexBuilder = %raw(`
function (knex, colName, like) {
  return knex.whereLike(colName, like);
}
`)

let applyILike: (knexBuilder, string, string) => knexBuilder = %raw(`
function (knex, colName, like) {
  return knex.whereILike(colName, like);
}
`)

let applyNot: (
  knexBuilder,
  string,
  'clar,
  (knexBuilder, string, 'clar) => knexBuilder,
) => knexBuilder = %raw(`
function (knex, colName, clar, convert) {
  knex = knex.clone();
  return knex.whereNot(builder => convert(builder, colName, clar));
}
`)

let applyAnd: (
  knexBuilder,
  string,
  array<'clar>,
  (knexBuilder, string, 'clar) => knexBuilder,
) => knexBuilder = %raw(`
function (knex, colName, clars, convert) {
  knex = knex.clone();
  clars.forEach(c => {
    knex = knex.andWhere(builder => convert(builder, colName, c));
  })
  return knex;
}
`)

let applyOr: (
  knexBuilder,
  string,
  array<'clar>,
  (knexBuilder, string, 'clar) => knexBuilder,
) => knexBuilder = %raw(`
function (knex, colName, clars, convert) {
  knex = knex.clone();
  clars.forEach(c => {
    knex = knex.orWhere(builder => convert(builder, colName, c));
  })
  return knex;
}
`)

let rec applyStringClarification = (
  knex: knexBuilder,
  colName: string,
  clar: stringClarification,
): knexBuilder =>
  switch clar {
  | Any => knex
  | Null => applyOnlyNull(knex, colName)
  | Not(subclar) => applyNot(knex, colName, subclar, applyStringClarification)
  | And(subclars) => applyAnd(knex, colName, subclars, applyStringClarification)
  | Or(subclars) => applyOr(knex, colName, subclars, applyStringClarification)
  | Eq(val) => applyEq(knex, colName, val)
  | More(val) => applyMore(knex, colName, val)
  | Less(val) => applyLess(knex, colName, val)
  | Between(v1, v2) => applyBetween(knex, colName, v1, v2)
  | In(vals) => applyIn(knex, colName, vals)
  | Like(val) => applyLike(knex, colName, val)
  | ILike(val) => applyILike(knex, colName, val)
  }

let rec applyIntClarification = (
  knex: knexBuilder,
  colName: string,
  clar: intClarification,
): knexBuilder =>
  switch clar {
  | Any => knex
  | Null => applyOnlyNull(knex, colName)
  | Not(subclar) => applyNot(knex, colName, subclar, applyIntClarification)
  | And(subclars) => applyAnd(knex, colName, subclars, applyIntClarification)
  | Or(subclars) => applyOr(knex, colName, subclars, applyIntClarification)
  | Eq(val) => applyEq(knex, colName, val)
  | More(val) => applyMore(knex, colName, val)
  | Less(val) => applyLess(knex, colName, val)
  | In(vals) => applyIn(knex, colName, vals)
  | Between(v1, v2) => applyBetween(knex, colName, v1, v2)
  }

let rec applyFloatClarification = (
  knex: knexBuilder,
  colName: string,
  clar: floatClarification,
): knexBuilder =>
  switch clar {
  | Any => knex
  | Null => applyOnlyNull(knex, colName)
  | Not(subclar) => applyNot(knex, colName, subclar, applyFloatClarification)
  | And(subclars) => applyAnd(knex, colName, subclars, applyFloatClarification)
  | Or(subclars) => applyOr(knex, colName, subclars, applyFloatClarification)
  | More(val) => applyMore(knex, colName, val)
  | Less(val) => applyLess(knex, colName, val)
  | Between(v1, v2) => applyBetween(knex, colName, v1, v2)
  }

let rec applyBoolClarification = (
  knex: knexBuilder,
  colName: string,
  clar: boolClarification,
): knexBuilder =>
  switch clar {
  | Any => knex
  | Null => applyOnlyNull(knex, colName)
  | Not(subclar) => applyNot(knex, colName, subclar, applyBoolClarification)
  | And(subclars) => applyAnd(knex, colName, subclars, applyBoolClarification)
  | Or(subclars) => applyOr(knex, colName, subclars, applyBoolClarification)
  | OnlyTrue => applyOnlyTrue(knex, colName)
  | OnlyFalse => applyOnlyFalse(knex, colName)
  }
