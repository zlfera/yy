defmodule ZzWeb.PageController do
  use ZzWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def root(conn, _params) do
    conn
    |> redirect(to: "/index.html")
  end
end
