defmodule Office.Litigation.Hearing do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Hearing

  def get!(id) do
    Phone
    |> Repo.get!(id)
  end

  def create_case_hearing(%{"hearing" => hearing_params} = params) do
    %Hearing{}
    |> Hearing.changeset(params)
    |> Repo.insert()
  end

  def update(id, attrs) do
    id
    |> get!()
    |> Hearing.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset do
    Hearing.changeset(%Hearing{})
  end

  def edit_changeset(id) do
    id
    |> get!
    |> Hearing.changeset
  end

  def delete(id) do
    Hearing
    |> Repo.get!(id)
    |> Hearing.changeset()
    |> Repo.delete
  end
end
