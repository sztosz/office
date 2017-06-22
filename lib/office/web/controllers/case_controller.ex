defmodule Office.Web.CaseController do
  use Office.Web, :controller

  alias Office.Litigation.Case
  alias Office.Litigation.Client
  alias Office.Litigation.Court
  alias Office.Litigation.Department

  plug :authenticate_user

  def index(conn, _params) do
    cases = Case.list_all()
    render(conn, "index.html", cases: cases)
  end

  def new(conn, _params) do
    changeset = Case.new_changeset
    render(conn, "new.html", changeset: changeset, selects: Case.selects)
  end

  def create(conn, %{"case" => case_params}) do
    case Case.create(case_params) do
      {:ok, case} ->
        conn
        |> put_flash(:info, "Case created successfully.")
        |> redirect(to: case_path(conn, :show, case))
      {:error,  %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, selects: Case.selects)
    end
  end

  def show(conn, %{"id" => id}) do
    case = Case.get!(id)
    render(conn, "show.html", case: case)
  end

  def edit(conn, %{"id" => id}) do
    clients = Client.list_all
    departments = Department.list_all
    # TODO: Change Enum to relation with translations.
    kinds = CaseKindsEnum.__enum_map__
    changeset = Case.edit_changeset(id)
    render(conn, "edit.html", id: id, changeset: changeset, clients: clients, departments: departments, kinds: kinds, conn: conn)
  end

  def edit(conn, %{"id" => id}) do
    changeset = Court.edit_changeset(id)
    render(conn, "edit.html", id: id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "case" => case_params}) do
    case Case.update(id, case_params) do
      {:ok, case} ->
        conn
        |> put_flash(:info, "Case updated successfully.")
        |> redirect(to: case_path(conn, :show, case))
      {:error, changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Case.delete(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Case deleted successfully.")
        |> redirect(to: case_path(conn, :index))
      _ ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> redirect(to: case_path(conn, :index))
    end
  end
end
