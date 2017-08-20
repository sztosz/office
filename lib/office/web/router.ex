defmodule OfficeWeb.Router do
  use OfficeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug OfficeWeb.Plugs.Locale
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: OfficeWeb.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OfficeWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/session/new", SessionController, :new
    post "/session/identity/callback", SessionController, :identity_callback
  end

  scope "/", OfficeWeb do
    pipe_through [:browser, :browser_auth]

    resources "/clients", ClientController do
      resources "/phones", PhoneController, except: [:index, :show]
      resources "/emails", EmailController, except: [:index, :show]
    end
    resources "/courts", CourtController do
      resources "/departments", DepartmentController
    end
    resources "/cases", CaseController
#    resources "/phones", PhoneController, except: [:index, :show]
#    resources "/emails", EmailController, except: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Office do
  #   pipe_through :api
  # end
end
