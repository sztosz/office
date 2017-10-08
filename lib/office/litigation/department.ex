defmodule Office.Litigation.Department do
  import Ecto, only: [assoc: 2]
  import Ecto.Query
  import Ecto.Changeset
  alias Ecto.Multi

  alias Office.Repo
  alias Office.Litigation.Court
  alias Office.Litigation.Schemas.Department
  alias Office.Litigation.Schemas.Case
  alias Office.Litigation.Schemas.Hearing

  def list_all_for_court(court) when is_binary(court) do
    court
    |> Court.get!
    |> list_all_for_court
  end

  def list_all_for_court(court) do
    court
    |> assoc(:departments)
    |> preload([:address, :court, :phone, :email])
    |> Repo.all
  end

  def list_all do
    Department
    |> Repo.all
  end

  def get!(id) do
    Department
    |> Repo.get!(id)
    |> Repo.preload([:court, :hearings, cases: [:plaintiff, :defendant]])
  end

  def create(attrs \\ %{}) do
    %Department{}
    |> Department.changeset(attrs)
    |> Repo.insert()
  end

  def update(id, attrs) do
    Department
    |> Repo.get!(id)
    |> Repo.preload([:address, :phone])
    |> Department.changeset(attrs)
    |> Repo.update()
  end

  def new_changeset(court_id) do
    court = Court.get!(court_id)
    Department.changeset(
      %Department{
        court_id: court_id,
        address: court.address,
        phone: court.phone
      }
    )
  end

  def edit_changeset(id) do
    Department
    |> Repo.get!(id)
    |> Repo.preload([:phone, :address])
    |> Department.changeset
  end

  def delete(id) do
    Multi.new
    |> Multi.delete_all(:hearings, department_hearings_delete_query(id))
    |> Multi.delete_all(:cases, department_cases_delete_query(id))
    |> Multi.delete_all(:department, department_delete_query(id))
    |> Repo.transaction()
  end

  defp department_delete_query(id) do
    from d in Department, where: d.id  == ^id
  end

  defp department_hearings_delete_query(id) do
    from h in Hearing, where: h.department_id  == ^id
  end

  defp department_cases_delete_query(id) do
    from c in Case,
         join: d in assoc(c, :department),
         on: d.id == c.department_id
  end
end
