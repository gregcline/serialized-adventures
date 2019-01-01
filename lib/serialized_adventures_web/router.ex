defmodule SerializedAdventuresWeb.Router do
  use SerializedAdventuresWeb, :router

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

  scope "/", SerializedAdventuresWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/plotless", PageController, :plotless

    resources "/story-groups", StoryGroupController
    resources "/stories", StoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SerializedAdventuresWeb do
  #   pipe_through :api
  # end
end
