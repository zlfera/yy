defmodule Plugs.OnePlug do
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> put_resp_header("cache-control", "max-age=3600, public")
  end
end
