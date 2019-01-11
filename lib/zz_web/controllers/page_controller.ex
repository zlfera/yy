defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def root(conn, _params) do
    e = File.read!("./priv/static/background_image.jpg") |> String.length()
    etag = ~s[W/"#{e |> :erlang.phash2() |> Integer.to_string(16)}"]

    conn =
      conn
      |> put_resp_header("etag", etag)
      |> put_resp_header("cache-control", "public")

    # |> put_status(:moved_permanently)

    if etag in get_req_header(conn, "if-none-match") do
      send_resp(304)
    else
      conn |> render("index.html")
    end
  end
end
