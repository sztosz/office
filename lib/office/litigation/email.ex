defmodule Office.Litigation.Email do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Email
  alias Office.Litigation.Schemas.ClientEmail

  def get!(id) do
    Email
    |> Repo.get!(id)
  end

  def create_client_email(%{"email" => email_params} = params) do
    %ClientEmail{}
    |> ClientEmail.changeset(params)
    |> Repo.insert()
  end

  def update(id, attrs) do
    id
    |> get!()
    |> Email.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    Email.changeset(%Email{})
  end

  def edit_changeset(id) do
    id
    |> get!
    |> Email.changeset
  end

  def delete_client_email(id, client_id) do
    Repo.delete_all(from cp in ClientEmail, where: cp.client_id == ^client_id and cp.email_id == ^id )
  end
end
