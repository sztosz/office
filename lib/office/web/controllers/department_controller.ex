defmodule Office.Web.DepartmentController do
  use Office.Web, :controller

  alias Office.Litigation.Department
  alias Office.Litigation.Court

  plug :authenticate_user

  def index(conn, %{"court_id" => court_id}) do
    court = Court.get!(court_id)
    departments = Department.list_all(court)

    render(conn, "index.html", departments: departments, court: court)
  end

  def new(conn, %{"court_id" => court_id}) do
    changeset = Department.new_changeset(court_id)
    render(conn, "new.html", changeset: changeset, court_id: court_id)
  end

  def create(conn, %{"court_id" => court_id, "department" => department_params}) do
    case Department.create(court_id, department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Court created successfully.")
        |> redirect(to: court_department_path(conn, :show, court_id, department))
      {:error,  %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
      {:error, :ivalid_court_id} ->
        conn
        |> put_flash(:info, "Invalid Court id in path.")
        |> redirect(to: court_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    department =
      Department
      |> Repo.get!(id)
      |> Repo.preload([:court, :cases])
    render(conn, "show.html", department: department)
  end

  def edit(conn, %{"id" => id}) do
    department = Repo.get!(Department, id)
    changeset = Department.changeset(department)
    render(conn, "edit.html", department: department, changeset: changeset)
  end

  def update(conn, %{"id" => id, "court_id" => court_id, "department" => department_params}) do
    department = Repo.get!(Department, id)
    changeset = Department.changeset(department, department_params)

    case Repo.update(changeset) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department updated successfully.")
        |> redirect(to: court_department_path(conn, :show, court_id, department))
      {:error, changeset} ->
        render(conn, "edit.html", department: department, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "court_id" => court_id}) do
    department = Repo.get!(Department, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(department)

    conn
    |> put_flash(:info, "Department deleted successfully.")
    |> redirect(to: court_department_path(conn, :index, court_id))
  end
end
