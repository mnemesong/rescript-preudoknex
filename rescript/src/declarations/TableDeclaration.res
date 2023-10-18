open ColumnDeclaration

type tableOption = Charset(string)

type tableDeclaration = TableDeclaration(string, array<columnDeclaration>, array<tableOption>)
