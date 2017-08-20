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
    |> preload(:address)
    |> Repo.get!(id)
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
    client_phone_delete_query = from cp in ClientPhone, where: cp.client_id == ^id
    client_email_delete_query = from cp in ClientEmail, where: cp.client_id == ^id
    client_delete_query = from c in Client, where: c.id  == ^id
    Multi.new
    |> Multi.delete_all(:client_phones, client_phone_delete_query)
    |> Multi.delete_all(:client_emails, client_email_delete_query)
    |> Multi.delete_all(:client, client_delete_query)
    |> Repo.transaction()
  end
end
