use Mix.Config

config :keeper, Keeper.Repo,
  adapter: Sqlite.Ecto2,
  database: "/root/#{Mix.env}.sqlite3"

config :keeper, ecto_repos: [Keeper.Repo]