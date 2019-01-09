defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> Plug.Conn.put_req_header("cache-control", "max-age=3600, private, must-revalidate")
    |> render("index.html")
  end
end
