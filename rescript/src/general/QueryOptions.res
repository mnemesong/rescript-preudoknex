type columnsSpec<'c> =
  | All
  | Columns(array<'c>)

type scalarResult =
  | Count
  | Min
  | Max
  | Sum
  | Avg

type orderParam<'c> =
  | Asc('c)
  | Desc('c)

type selectOption<'c> =
  | Offset(int)
  | Limit(int)
  | OrderBy(array<orderParam<'c>>)
