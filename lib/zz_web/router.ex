defmodule ZzWeb.Router do
  use ZzWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_resp_header, ["cache-control", "max-age=3, public, must-revalidate"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZzWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/index", HomeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ZzWeb do
  #   pipe_through :api
  # end
end
