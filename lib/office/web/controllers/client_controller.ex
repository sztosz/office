defmodule OfficeWeb.ClientController do
  use OfficeWeb, :controller

  alias OfficeWeb.ErrorHelpers
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
      {:error, %{errors: errors}} ->
        conn
        |> put_flash(:error, ErrorHelpers.flash_errors(errors))
        |> redirect(to: client_path(conn, :show, id))
      _ ->
        conn
        |> put_flash(:error, "Something got really sideways!")
        |> redirect(to: client_path(conn, :show, id))
    end
  end

end

