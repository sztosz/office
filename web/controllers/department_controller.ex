defmodule Office.DepartmentController do
  use Office.Web, :controller

  alias Office.Department

  def index(conn, %{"court_id" => court_id}) do
    court = Repo.get!(Office.Court, court_id)
    departments = Repo.all(assoc(court, :departments))

    render(conn, "index.html", departments: departments, court: court)
  end

  def new(conn, %{"court_id" => court_id}) do
    changeset = Department.changeset(%Department{court_id: court_id})
    render(conn, "new.html", changeset: changeset, court_id: court_id)
  end

  def create(conn, %{"department" => department_params, "court_id" => court_id}) do
    with {val, _} <- Integer.parse(court_id),
         changeset = Department.changeset(%Department{court_id: val}, department_params),
         {:ok, department} <- Repo.insert(changeset)
    do conn
       |> put_flash(:info, "Department created successfully.")
       |> redirect(to: court_department_path(conn, :index, court_id))
    else :error -> conn
                   |> put_flash(:info, "Invalid Court id in path.")
                   |> redirect(to: court_path(conn, :index))
         {:error, changeset} -> render(conn, "new.html", changeset: changeset, court_id: court_id)
    end
  end

  def show(conn, %{"id" => id, "court_id" => court_id}) do
    department =
      Department
      |> Repo.get!(id)
      |> Repo.preload([:court])
    render(conn, "show.html", department: department)
  end

  def edit(conn, %{"id" => id, "court_id" => court_id}) do
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