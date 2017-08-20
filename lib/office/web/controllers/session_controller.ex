defmodule OfficeWeb.SessionController do
  use OfficeWeb, :controller
  alias Office.Auth.Auth
  alias Ueberauth.Strategy.Helpers

  plug Ueberauth

  def new(conn, _) do
    render(conn, "new.html", callback_url: Helpers.callback_url(conn), current_user: nil)
  end

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _) do
    auth = Auth.authenticate(auth)
    authenticated(conn, auth)
  end

  defp authenticated(conn, {:ok, user}) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: page_path(conn, :index))
  end

  defp authenticated(conn, {:error, error}) do
    conn
    |> put_flash(:error, error)
    |> render("new.html", callback_url: Helpers.callback_url(conn))
  end
end
