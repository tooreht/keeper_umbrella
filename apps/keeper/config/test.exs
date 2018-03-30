use Mix.Config

# Configure your database
config :keeper, Keeper.Repo,
  adapter: Sqlite.Ecto2,
  database: "#{Mix.env}.sqlite3"
  pool: Ecto.Adapters.SQL.Sandbox
