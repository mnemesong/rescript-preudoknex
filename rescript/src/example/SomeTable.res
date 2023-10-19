open Clarification
open QueryOptions

module SomeTable = {
  //Superspecific
  type record = {
    uuid: string,
    name: string,
    val: int,
  }

  //Superspecific
  type column = [
    | #uuid
    | #name
    | #val
  ]

  type setColumn =
    | Uuid(string)
    | Name(string)
    | Val(int)

  //Superspecific
  type rec tableClar =
    | WhereUuid(stringClarification)
    | WhereName(stringClarification)
    | WhereVal(intClarification)
    | AndWhere(array<tableClar>)
    | OrWhere(array<tableClar>)

  type selectFirstFun = (columnsSpec<column>, tableClar) => option<record>

  type selectAll = (columnsSpec<column>, tableClar, selectOption<column>) => array<record>

  type selectScalar = (scalarResult, columnsSpec<column>, tableClar) => option<scalarResult>

  type updateColumns = (array<setColumn>, tableClar) => result<unit, string>

  type updateRecord = (string, record) => result<unit, string>

  type insertRecords = array<record> => result<array<record>, string>

  type deleteRecords = tableClar => result<unit, string>
}
