defmodule Office.Web.Plugs.Authorization do
  import Plug.Conn
  import Phoenix.Controller

  alias Office.Auth.Auth
  alias Office.Web.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    cond do
      user = conn.assigns[:current_user] ->
        put_current_user(conn, user)
        # TODO: REFACTOR OUT TO CONTEXT
      user = user_id && repo.get(Office.Auth.User, user_id) ->
        put_current_user(conn, user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    case Auth.authenticate_user(conn.assigns.current_user) do
      {:ok, _} ->
        conn
      {:error, _} ->
        conn
        |> put_flash(:error, "You must be logged in!")
        |> redirect(to: Helpers.session_path(conn, :new))
        |> halt
    end
  end

  def login(conn, user) do
    conn
    |> put_current_user(user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  defp put_current_user(conn, user) do
    assign(conn, :current_user, user)
  end
end
