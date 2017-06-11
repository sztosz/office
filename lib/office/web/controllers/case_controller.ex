defmodule Office.Web.CaseController do
  use Office.Web, :controller

  alias Office.Litigation.Case

  plug :authenticate_user

  def index(conn, _params) do
    cases = Case.list_all()
    render(conn, "index.html", cases: cases)
  end

  def new(conn, _params) do
    changeset = Litigation.Case.new_changeset

    clients = Repo.all(Client)
    departments = Repo.all(Department)
    kinds = CaseKindsEnum.__enum_map__

    render(conn, "new.html", changeset: changeset, clients: clients, departments: departments, kinds: kinds)
  end

  def create(conn, %{"case" => case_params}) do
    case Case.create(case_params) do
      {:ok, case} ->
        conn
        |> put_flash(:info, "Case created successfully.")
        |> redirect(to: case_path(conn, :show, case))
      {:error,  %Ecto.Changeset{} = changeset} ->
        clients = Repo.all(Client)
        render(conn, "new.html", changeset: changeset, clients: clients)
    end
  end

  def show(conn, %{"id" => id}) do
    case = Case.get!(id)
    render(conn, "show.html", case: case)
  end

  def edit(conn, %{"id" => id}) do
    clients = Repo.all(Client)
    departments = Repo.all(Department)
    kinds = CaseKindsEnum.__enum_map__
    case = Repo.get!(Case, id)
    changeset = Case.changeset(case)
    render(conn, "edit.html", case: case, changeset: changeset, clients: clients, departments: departments, kinds: kinds, conn: conn)
  end

  def update(conn, %{"id" => id, "case" => case_params}) do
    case = Repo.get!(Case, id)
    changeset = Case.changeset(case, case_params)

    case Repo.update(changeset) do
      {:ok, case} ->
        conn
        |> put_flash(:info, "Case updated successfully.")
        |> redirect(to: case_path(conn, :show, case))
      {:error, changeset} ->
        render(conn, "edit.html", case: case, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case = Repo.get!(Case, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(case)

    conn
    |> put_flash(:info, "Case deleted successfully.")
    |> redirect(to: case_path(conn, :index))
  end
end
