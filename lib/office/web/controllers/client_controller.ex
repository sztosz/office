defmodule Office.Web.ClientController do
  use Office.Web, :controller

  alias Office.Client
  alias Office.Phone
  alias Office.Email

  require IEx

  plug :authenticate_user

  def index(conn, _params) do
    clients = Repo.all(Client)
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    changeset =
      Client.changeset(
        %Client{phones: [%Phone{}, %Phone{}, %Phone{}], emails: [%Email{}, %Email{}, %Email{}]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    changeset = Client.changeset(%Client{}, client_params)

    case Repo.insert(changeset) do
      {:ok, _client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: client_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)
    render(conn, "show.html", client: client)
  end

  # TODO: Heavy refactor obviously neeeded ;)
  def edit(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)
    emails_len = length(client.emails)
    phones_len = length(client.phones)

    if emails_len < 3 do
      emails = client.emails ++ for _ <- 1..(3 - emails_len) do
        %Email{}
      end
      client = %{client | emails: emails}
    end

    phones = if phones_len < 3 do
      phones = client.phones ++ for _ <- 1..3 - phones_len do
        %Phone{}
      end
      client = %{client | phones: phones}
    end

    changeset = Client.changeset(client)

    render(conn, "edit.html", client: client, changeset: changeset)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Repo.get!(Client, id)
    changeset = Client.changeset(client, client_params)

    case Repo.update(changeset) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: client_path(conn, :show, client))
      {:error, changeset} ->
        render(conn, "edit.html", client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Repo.get!(Client, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: client_path(conn, :index))
  end
end
