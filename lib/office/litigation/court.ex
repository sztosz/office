defmodule Office.Litigation.Court do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Court

  def get!(id) do
    Court
    # |> preload([department: :court])
    # |> preload([:plaintiff, :defendant])
    |> Repo.get!(id)
  end

  def changeset(%Court{} = court) do
    court
    |> Court.changeset()
  end

  def new_changeset do
    changeset(%Court{})
  end
end
