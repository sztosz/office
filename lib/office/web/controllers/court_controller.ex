defmodule OfficeWeb.CourtController do
  use OfficeWeb, :controller

  alias OfficeWeb.ErrorHelpers
  alias Office.Litigation.Court

#  plug :authenticate_user

  def index(conn, _params) do
    courts = Court.list_all
    render(conn, "index.html", courts: courts)
  end

  def new(conn, _params) do
    changeset = Court.new_changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"court" => court_params}) do
    case Court.create(court_params) do
      {:ok, court} ->
        conn
        |> put_flash(:info, "Court created successfully.")
        |> redirect(to: court_path(conn, :show, court))
      {:error,  %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    court = Court.get!(id)
    render(conn, "show.html", court: court)
  end

  def edit(conn, %{"id" => id}) do
    changeset = Court.edit_changeset(id)
    render(conn, "edit.html", id: id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "court" => court_params}) do
    case Court.update(id, court_params) do
      {:ok, court} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: court_path(conn, :show, court))
      {:error, changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Court.delete(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Court deleted successfully.")
        |> redirect(to: court_path(conn, :index))
      {:error, %{errors: errors}} ->
        conn
        |> put_flash(:error, ErrorHelpers.flash_errors(errors))
        |> redirect(to: court_path(conn, :show, id))
      x ->
        IO.inspect(x)
        conn
        |> put_flash(:error, "Something got really sideways!")
        |> redirect(to: court_path(conn, :show, id))
    end
  end
end
