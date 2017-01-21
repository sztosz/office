defmodule Office.Router do
  use Office.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Office.Plugs.Auth, repo: Office.Repo
    plug Office.Plugs.Locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Office do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/clients", ClientController
    resources "/sessions", SessionController, only: [:new, :create]
    resources "/courts", CourtController do
      resources "/departments", DepartmentController
    end
    resources "/cases", CaseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Office do
  #   pipe_through :api
  # end
end
