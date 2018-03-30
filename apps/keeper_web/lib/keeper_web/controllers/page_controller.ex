defmodule KeeperWeb.PageController do
  use KeeperWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
