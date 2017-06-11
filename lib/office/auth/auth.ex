defmodule Office.Auth.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Office.Auth.User, as: User

  def authenticate_user(user) do
    case user do
     %User{} ->
       {:ok, user}
     nil ->
       {:error, :unauthenticated}
    end
  end

  def login_by_username_and_and_pass(username, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Office.User, username: username)

    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end
end
