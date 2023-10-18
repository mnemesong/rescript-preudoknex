type incrementsConfig = PrimaryKey

type intTypeConfig =
  | Unsigned
  | CheckPositive
  | CheckNegative
  | CheckBetween(int, int)
  | CheckIn(array<int>)
  | CheckNotIn(array<int>)
  | CheckLength(int)

type intSubtype =
  | TinyInt
  | SmallInt
  | MediumInt
  | BigInt

type floatValConfig =
  | Precision(int)
  | Scale(int)
  | Unsigned
  | CheckPositive
  | CheckNegative
  | CheckBetween(float, float)
  | CheckIn(array<float>)
  | CheckNotIn(array<float>)
  | CheckLength(float)

type floatSubtype =
  | Float
  | Double

type dateTimeConfig =
  | UseTz
  | Precision(int)

type timeConfig = Precision(int)

type binaryConfig = Length(int)

type valueTypeDeclaration =
  | Increments(array<incrementsConfig>)
  | Integer(intSubtype, array<intTypeConfig>)
  | Text
  | String(int)
  | Float(floatSubtype, array<floatValConfig>)
  | Boolean
  | Date
  | DateTime(array<dateTimeConfig>)
  | Time(array<timeConfig>)
  | Timestamp(dateTimeConfig)
  | Binary(binaryConfig)
