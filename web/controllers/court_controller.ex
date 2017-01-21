defmodule Office.CourtController do
  use Office.Web, :controller

  alias Office.Court

  def index(conn, _params) do
    courts =
      Court
      |> Repo.all
      |> Repo.preload(:departments)
    render(conn, "index.html", courts: courts)
  end

  def new(conn, _params) do
    changeset = Court.changeset(%Court{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"court" => court_params}) do
    changeset = Court.changeset(%Court{}, court_params)

    case Repo.insert(changeset) do
      {:ok, _court} ->
        conn
        |> put_flash(:info, "Court created successfully.")
        |> redirect(to: court_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    court = Repo.get!(Court, id)
    render(conn, "show.html", court: court)
  end

  def edit(conn, %{"id" => id}) do
    court = Repo.get!(Court, id)
    changeset = Court.changeset(court)
    render(conn, "edit.html", court: court, changeset: changeset)
  end

  def update(conn, %{"id" => id, "court" => court_params}) do
    court = Repo.get!(Court, id)
    changeset = Court.changeset(court, court_params)

    case Repo.update(changeset) do
      {:ok, court} ->
        conn
        |> put_flash(:info, "Court updated successfully.")
        |> redirect(to: court_path(conn, :show, court))
      {:error, changeset} ->
        render(conn, "edit.html", court: court, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    court = Repo.get!(Court, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(court)

    conn
    |> put_flash(:info, "Court deleted successfully.")
    |> redirect(to: court_path(conn, :index))
  end
end
