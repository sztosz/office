defmodule Office.Litigation.Client do
  import Ecto.Query
  import Ecto.Changeset

  alias Office.Repo
  alias Office.Litigation.Schemas.Client
  alias Office.Litigation.Schemas.Email
  alias Office.Litigation.Schemas.Phone

  def list_all do
    Repo.all(Client)
  end

  def get!(id) do
    Client
    |> Repo.get!(id)
  end

  def create(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  def update(id, attrs) do
    Client
    |> Repo.get!(id)
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  def changeeset(%Client{} = client) do
    client
    |> Client.changeset()
    # |> cast_assoc(:plaintiff)
    # |> cast_assoc(:defendant)
    # |> cast_assoc(:department)
  end

  def new_changeset do
    change(%Client{})
  end

  def edit_changeset(id) do
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
  end

end
