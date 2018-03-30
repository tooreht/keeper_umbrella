use Mix.Config

config :keeper, ecto_repos: [Keeper.Repo]

import_config "#{Mix.env}.exs"
