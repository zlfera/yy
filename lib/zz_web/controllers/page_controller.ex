defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn =
      conn
      |> put_resp_header("cache-control", "public,max-age=3600")

    render(conn, "index.html")
  end
end
