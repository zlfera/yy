defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn =
      Plug.Conn.put_resp_header(conn, "cache-control", "public, max-age=43200, must-revalidate")

    render(conn, "index.html")
  end
end
