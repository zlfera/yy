defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> Plug.Conn.put_resp_header("Cache-Control", "max-age=3600, public")
    |> render("index.html")
  end
end
