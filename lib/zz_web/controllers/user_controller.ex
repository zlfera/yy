defmodule ZzWeb.UserController do
  use ZzWeb, :controller

  alias Zz.Accounts
  alias Zz.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    {:ok, pid} = Agent.start_link(fn -> 0 end)
    render(conn, "index.html", users: users, pid: pid)
  end
end
