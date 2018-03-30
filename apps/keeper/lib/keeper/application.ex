defmodule Keeper.Application do
  @moduledoc """
  The Keeper Application Service.

  The keeper system business domain lives in this application.

  Exposes API to clients such as the `KeeperWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Keeper.Repo, []),
    ], strategy: :one_for_one, name: Keeper.Supervisor)
  end
end
