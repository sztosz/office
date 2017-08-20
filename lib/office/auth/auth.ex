defmodule Office.Auth.Auth do
  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]

  alias Office.Auth.Schemas.User
  alias Ueberauth.Auth
  alias Office.Repo

  def authenticate(%Auth{provider: :identity} = auth) do
    Repo.get_by(User, email: auth.uid)
    |> authorize(auth)
  end

  defp authorize(nil, _auth), do: {:error, "Invalid username or password"}
  defp authorize(user, auth) do
    checkpw(auth.credentials.other.password, user.password)
    |> resolve_authorization(user)
  end

  defp resolve_authorization(false, _user), do: {:error, "Invalid username or password"}
  defp resolve_authorization(true, user), do: {:ok, user}
end
