defmodule ZzWeb.StaticcController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_file(200, "./lib/zz_web/templates/staticc/index.html")
  end
end
