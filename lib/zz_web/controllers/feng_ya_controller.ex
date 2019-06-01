defmodule ZzWeb.FengYaController do
  use ZzWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
