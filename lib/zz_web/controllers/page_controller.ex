defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_header("cache-control", "public,max-age=3600")
    |> render("index.html")
  end
end
