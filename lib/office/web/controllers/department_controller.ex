defmodule OfficeWeb.DepartmentController do
  use OfficeWeb, :controller

  alias Office.Litigation.Department
  alias Office.Litigation.Court

#  plug :authenticate_user

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
    case Map.put(department_params, "court_id", court_id) |> Department.create do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Court created successfully.")
        |> redirect(to: court_department_path(conn, :show, court_id, department))
      {:error,  %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, court_id: court_id)
    end
  end

  def show(conn, %{"id" => id}) do
    department = Department.get!(id)
    render(conn, "show.html", department: department)
  end

  def edit(conn, %{"id" => id}) do
    changeset = Department.edit_changeset(id)
    render(conn, "edit.html", id: id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "court_id" => court_id, "department" => department_params}) do
    case Department.update(id, department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department updated successfully.")
        |> redirect(to: court_department_path(conn, :show, court_id, department))
      {:error, changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "court_id" => court_id}) do
    case Department.delete(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Court deleted successfully.")
        |> redirect(to: court_department_path(conn, :index, court_id))
      {:error, :cases, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete all cases.")
        |> redirect(to: court_department_path(conn, :show, court_id))
      {:error, :hearings, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete all hearings.")
        |> redirect(to: court_department_path(conn, :show, court_id))
      {:error, :department, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete department.")
        |> redirect(to: court_department_path(conn, :show, court_id))
    end
  end
end
