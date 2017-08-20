defmodule OfficeWeb.PhoneController do
  use OfficeWeb, :controller

  alias Office.Litigation.Phone

  def new(conn, %{"client_id" => client_id}) do
    changeset = Phone.new_changeset
    render(conn, "new.html", changeset: changeset, client_id: client_id)
  end

  def create(conn, %{"client_id" => client_id} = params) do
    case Phone.create_client_phone(params) do
      {:ok, phone} ->
        conn
        |> put_flash(:info, "Phone created successfully.")
        |> redirect(to: client_path(conn, :show, client_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id, "client_id" => client_id}) do
    phone = Phone.get!(id)
    changeset = Phone.edit_changeset(id)
    render(conn, "edit.html", phone: phone, client_id: client_id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "phone" => phone_params, "client_id" => client_id}) do
    case Phone.update(id, phone_params) do
      {:ok, phone} ->
        conn
        |> put_flash(:info, "Phone updated successfully.")
        |> redirect(to: client_path(conn, :show, client_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "client_id" => client_id}) do
    flash_msg = case Phone.delete_client_phone(id, client_id) do
      {1, _} ->
        "Phone deleted successfully."
      {_, _} ->
        "Something went wrong."
    end

    conn
    |> put_flash(:info, flash_msg)
    |> redirect(to: client_path(conn, :show, client_id))
  end
end
