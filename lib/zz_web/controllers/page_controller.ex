defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_header("cache-control", "max-age=3600, public")
    |> put_resp_header("connection", "close")
    |> render("index.html")
  end
end
