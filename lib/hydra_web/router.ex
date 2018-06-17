defmodule HydraWeb.Router do
  use HydraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HydraWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
