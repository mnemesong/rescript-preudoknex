open ValueTypeDeclaration

type columnOption =
  | Index
  | Primary
  | Unique
  | Foreign(string)
  | ForeignInTable(string, string)
  | Nullable
  | CheckPositive
  | CheckNegative
  | CheckIn(array<string>)
  | CheckNotIn(array<string>)
  | CheckBetween

type columnDeclaration = Column(string, valueTypeDeclaration, array<columnOption>)
