defmodule Office.Auth.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Office.Repo
  alias Office.Auth.Schemas.User

  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: { :error, "Unknown resource type" }
end
