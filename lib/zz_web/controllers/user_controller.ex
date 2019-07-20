defmodule ZzWeb.UserController do
  use ZzWeb, :controller

  alias Zz.Accounts
  alias Zz.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end
end
