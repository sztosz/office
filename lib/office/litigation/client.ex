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
    Multi.new
    |> Multi.delete_all(:client_phones, client_phone_delete_query(id))
    |> Multi.delete_all(:client_emails, client_email_delete_query(id))
    |> Multi.delete_all(:client_cases, client_cases_delete_query(id))
    |> Multi.delete_all(:client, client_delete_query(id))
    |> Repo.transaction()
  end

  defp client_phone_delete_query(id) do
    from cp in ClientPhone, where: cp.client_id == ^id
  end

  defp client_email_delete_query(id) do
    from ce in ClientEmail, where: ce.client_id == ^id
  end

  defp client_cases_delete_query(id) do
    from c in Case, where: c.plaintiff_id == ^id, or_where: c.defendant_id == ^id
  end

  defp client_delete_query(id) do
    from c in Client, where: c.id  == ^id
  end
end
