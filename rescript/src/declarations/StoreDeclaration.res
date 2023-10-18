open TableDeclaration

type mysqlConfig = {
  host: string,
  port: int,
  user: string,
  password: string,
  database: string,
}

type postgreSqlConfig = {
  connectionString: string,
  host: string,
  port: int,
  user: string,
  database: string,
  password: string,
  ssl: bool,
}

type sqliteConfigFlag =
  | SqliteOpenUri
  | SqliteOpenSharedCache

type sqliteConfig = {
  filename: string,
  flags: array<sqliteConfigFlag>,
}

type storageType =
  | SQLite3(sqliteConfig)
  | MySQL(mysqlConfig)

type storageDeclaration = StorageDeclaration(string, storageType, array<tableDeclaration>)
