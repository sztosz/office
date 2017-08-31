defmodule Office.Litigation.Case do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Case
  alias Office.Litigation.Client
  alias Office.Litigation.Department

  def list_all do
    query = from case in Case,
      preload: [department: :court],
      preload: [department: :address],
      preload: [:plaintiff, :defendant]
    Repo.all(query)
  end

  def get!(id) do
    Case
    |> preload([department: :court])
    |> preload([department: :address])
    |> preload([department: :phone])
    |> preload([department: :email])
    |> preload([:plaintiff, :defendant, :hearings])
    |> Repo.get!(id)
  end

  def create(attrs \\ %{}) do
    %Case{}
    |> Case.changeset(attrs)
    |> Repo.insert()
  end

  def update(id, attrs) do
    Case
    |> Repo.get!(id)
    |> Case.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    changeset(%Case{})
  end

  def edit_changeset(id) do
     Case
     |> Repo.get!(id)
     |> changeset
   end

  def selects do
    %{
      clients: Client.list_all,
      departments: Department.list_all,
      kinds: CaseKindsEnum.__enum_map__
     }
   end

  defp changeset(%Case{} = case) do
    case
    |> Case.changeset()
    |> cast_assoc(:plaintiff)
    |> cast_assoc(:defendant)
    |> cast_assoc(:department)
  end
end
