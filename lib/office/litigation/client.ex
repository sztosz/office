defmodule Office.Litigation.Client do
  import Ecto.Query
  import Ecto.Changeset
  alias Ecto.Multi

  alias Office.Repo
  alias Office.Litigation.Schemas.Client
  alias Office.Litigation.Schemas.Email
  alias Office.Litigation.Schemas.ClientEmail
  alias Office.Litigation.Schemas.Phone
  alias Office.Litigation.Schemas.ClientPhone
  alias Office.Litigation.Schemas.Case
  alias Office.Litigation.Schemas.Hearing

  def list_all do
    Client
    |> preload([:phones, :emails, :address])
    |> Repo.all
  end

  def get!(id) do
    Client
    |> preload([:phones, :emails, :address])
    |> Repo.get!(id)
  end

  def create(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  def update(id, attrs) do
    Client
    |> Repo.get!(id)
    |> Repo.preload(:address)
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    Client.changeset(%Client{})
  end

  def edit_changeset(id) do
    Client
    |> preload(:address)
    |> Repo.get!(id)
    |> Client.changeset
  end

  def delete(id) do
    Client
    |> Repo.get!(id)
    |> Client.changeset()
    |> Repo.delete
  end
end
