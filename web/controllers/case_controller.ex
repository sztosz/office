defmodule Office.CaseController do
  use Office.Web, :controller

  alias Office.Case

  def index(conn, _params) do
    cases = Repo.all(Case)
    render(conn, "index.html", cases: cases)
  end

  def new(conn, _params) do
    changeset = Case.changeset(%Case{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"case" => case_params}) do
    changeset = Case.changeset(%Case{}, case_params)

    case Repo.insert(changeset) do
      {:ok, _case} ->
        conn
        |> put_flash(:info, "Case created successfully.")
        |> redirect(to: case_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case = Repo.get!(Case, id)
    render(conn, "show.html", case: case)
  end

  def edit(conn, %{"id" => id}) do
    case = Repo.get!(Case, id)
    changeset = Case.changeset(case)
    render(conn, "edit.html", case: case, changeset: changeset)
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
