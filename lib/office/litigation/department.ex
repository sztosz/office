defmodule Office.Litigation.Department do
  import Ecto, only: [assoc: 2]
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Department

  def list_all(court) do
    Repo.all(assoc(court, :departments))
  end

  def create(court_id, attrs \\ %{})
  def create(court_id, attrs) when is_integer(court_id) do
    %Department{court_id: court_id}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  def create(court_id, attrs) do
    {:error, :ivalid_court_id}
  end

  def changeset(%Department{} = department) do
    department
    |> Department.changeset()
  end

  def new_changeset(court_id) do
    changeset(%Department{court_id: court_id})
  end
end
