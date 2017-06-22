defmodule Office.Litigation.Department do
  import Ecto, only: [assoc: 2]
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Department

  def list_all_for_court(court) when is_binary(court) do
    court
    |> Court.get!
    |> list_all_for_court
  end

  def list_all_for_court(court) do
    court
    |> assoc(:departments)
    |> Repo.all
  end

  def list_all do
    Department
    |> Repo.all
  end

  def get!(id) do
    Department
    |> Repo.get!(id)
    |> Repo.preload([:court, :cases])
  end

  def create(court_id, attrs \\ %{})
  def create(court_id, attrs) when is_integer(court_id) do
    %Department{court_id: court_id}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  def create(court_id, attrs) when is_binary(court_id) do
    case (Integer.parse(court_id)) do
      :error -> {:error, :ivalid_court_id}
      {int, _} -> create(int, attrs)
    end

  end

  def update(id, attrs) do
    Department
    |> Repo.get!(id)
    |> Department.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset(court_id) do
    Department.changeset(%Department{court_id: court_id})
  end

  def edit_changeset(id) do
    Department
    |> Repo.get!(id)
    |> Department.changeset
  end

  def delete(id) do
    Department
    |> Repo.get!(id)
    |> Repo.delete
  end
end
