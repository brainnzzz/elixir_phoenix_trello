defmodule TrelloWeb.Router do
  use TrelloWeb, :router

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

  scope "/", TrelloWeb do
    pipe_through :browser # Use the default browser stack

    get "*path", PageController, :index
  end

  scope "/api", TrelloWeb do
    pipe_through :api

    scope "/v1" do
      post "/registration", RegistrationController, :create
    end
  end
end
