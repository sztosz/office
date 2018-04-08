defmodule OfficeWeb.EmailController do
  use OfficeWeb, :controller

  alias Office.Litigation.Email

  def new(conn, %{"client_id" => client_id}) do
    changeset = Email.new_changeset()
    render(conn, "new.html", changeset: changeset, client_id: client_id)
  end

  def create(conn, %{"client_id" => client_id} = params) do
    case Email.create_client_email(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Email created successfully.")
        |> redirect(to: client_path(conn, :show, client_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "client_id" => client_id}) do
    email = Email.get!(id)
    changeset = Email.edit_changeset(id)
    render(conn, "edit.html", email: email, client_id: client_id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "email" => email_params, "client_id" => client_id}) do
    case Email.update(id, email_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Email updated successfully.")
        |> redirect(to: client_path(conn, :show, client_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "client_id" => client_id}) do
    flash_msg =
      case Email.delete_client_email(id, client_id) do
        {1, _} -> "Email deleted successfully."
        {_, _} -> "Something went wrong."
      end

    conn
    |> put_flash(:info, flash_msg)
    |> redirect(to: client_path(conn, :show, client_id))
  end
end
