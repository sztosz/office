defmodule Office.Litigation.Case do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Case

  def list_all do
    query = from case in Case,
      preload: [department: :court],
      preload: [:plaintiff, :defendant]
    Repo.all(query)
  end

  def get!(id) do
    Case
    |> preload([department: :court])
    |> preload([:plaintiff, :defendant])
    |> Repo.get!(id)
  end

  def create(attrs \\ %{}) do
    %Case{}
    |> Case.changeset(attrs)
    |> Repo.insert()
  end

  def changeset(%Case{} = case) do
    case
    |> Case.changeset()
    |> cast_assoc(:plaintiff)
    |> cast_assoc(:defendant)
    |> cast_assoc(:department)
  end

  def new_changeset do
    changeset(%Case{})
  end
end
