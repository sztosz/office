defmodule OfficeWeb.HearingController do
  use OfficeWeb, :controller

  alias Office.Litigation.Hearing

  def new(conn, %{"case_id" => case_id}) do
    changeset = Hearing.new_changeset
    render(conn, "new.html", changeset: changeset, case_id: case_id)
  end

  def create(conn, %{"case_id" => case_id} = params) do
    case Hearing.create_case_hearing(params) do
      {:ok, phone} ->
        conn
        |> put_flash(:info, "Hearing created successfully.")
        |> redirect(to: case_path(conn, :show, case_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "case_id" => case_id}) do
    hearing = Hearing.get!(id)
    changeset = Hearing.edit_changeset(id)
    render(conn, "edit.html", hearing: hearing, case_id: case_id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hearing" => hearing_params, "case_id" => case_id}) do
    case Hearing.update(id, hearing_params) do
      {:ok, hearing} ->
        conn
        |> put_flash(:info, "Hearing updated successfully.")
        |> redirect(to: case_path(conn, :show, case_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "case_id" => case_id}) do
    flash_msg = case Hearing.delete_case_hearing(id, case_id) do
      {1, _} ->
        "Hearing deleted successfully."
      {_, _} ->
        "Something went wrong."
    end

    conn
    |> put_flash(:info, flash_msg)
    |> redirect(to: case_path(conn, :show, case_id))
  end
end
