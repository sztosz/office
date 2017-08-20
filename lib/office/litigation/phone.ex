defmodule Office.Litigation.Phone do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Phone
  alias Office.Litigation.Schemas.ClientPhone

  def get!(id) do
    Phone
    |> Repo.get!(id)
  end

  def create_client_phone(%{"phone" => phone_params} = params) do
    %ClientPhone{}
    |> ClientPhone.changeset(params)
    |> Repo.insert()
  end

  def update(id, attrs) do
    id
    |> get!()
    |> Phone.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    Phone.changeset(%Phone{})
  end

  def edit_changeset(id) do
    id
    |> get!
    |> Phone.changeset
  end

  def delete_client_phone(id, client_id) do
    Repo.delete_all(from cp in ClientPhone, where: cp.client_id == ^client_id and cp.phone_id == ^id )
  end
end
