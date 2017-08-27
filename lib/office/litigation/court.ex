defmodule Office.Litigation.Court do
  import Ecto.Query
  import Ecto.Changeset
  alias Ecto.Multi

  alias Office.Repo
  alias Office.Litigation.Schemas.Court
  alias Office.Litigation.Schemas.Department
  alias Office.Litigation.Schemas.Case
  alias Office.Litigation.Schemas.Phone
  alias Office.Litigation.Schemas.Address

  def list_all do
    Court
    |> Repo.all
    |> Repo.preload([:departments, :address, :phone])
  end

  def get!(id) do
    Court
    |> Repo.get!(id)
    |> Repo.preload(:departments)
    |> Repo.preload(:phone)
    |> Repo.preload(:address)
  end

  def create(attrs \\ %{}) do
    %Court{}
    |> Court.changeset(attrs)
    |> Repo.insert()
  end

  def update(id, attrs) do
    Court
    |> Repo.get!(id)
    |> Court.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    Court.changeset(%Court{})
  end

  def edit_changeset(id) do
    id
    |> get!
    |> Court.changeset
  end

  def delete(id) do
    court = get!(id)
    phone_id = court.phone_id
    address_id = court.address_id
    Multi.new
    |> Multi.delete(:department, court     |> Court.changeset())
    |> Multi.delete(:phone, court.phone)
    |> Multi.delete(:address, court.address)
    |> Repo.transaction()
  end
end
