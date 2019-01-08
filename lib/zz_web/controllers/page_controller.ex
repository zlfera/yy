defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn = Plug.Conn.put_resp_header(conn, "cache_control", "public,max-age=3600")
    render(conn, "index.html", c: conn)
  end
end
