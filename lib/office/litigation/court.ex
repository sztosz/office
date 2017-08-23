defmodule Office.Litigation.Court do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Court

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
    id
    |> get!
    |> Repo.delete
  end
end
