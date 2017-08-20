defmodule OfficeWeb.ClientController do
  use OfficeWeb, :controller

  alias Office.Litigation.Client

  def index(conn, _params) do
    clients = Client.list_all
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    changeset = Client.new_changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    case Client.create(client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: client_path(conn, :show, client))
      {:error,  %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Client.get!(id)
    render(conn, "show.html", client: client)
  end

  def edit(conn, %{"id" => id}) do
    changeset = Client.edit_changeset(id)
    render(conn, "edit.html", id: id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    case Client.update(id, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: client_path(conn, :show, client))
      {:error, changeset} ->
        render(conn, "edit.html", id: id, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Client.delete(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Client deleted successfully.")
        |> redirect(to: client_path(conn, :index))
      {:error, :client_phones, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete all phones.")
        |> redirect(to: client_path(conn, :show, id))
      {:error, :client_emails, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete all emails.")
        |> redirect(to: client_path(conn, :show, id))
      {:error, :client, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong, can't delete client.")
        |> redirect(to: client_path(conn, :show, id))
    end
  end
end

