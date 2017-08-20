defmodule Office.Litigation.Schemas.ClientEmail do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.ClientEmail

  schema "clients_emails" do
    belongs_to :client, Office.Litigation.Schemas.Client
    belongs_to :email, Office.Litigation.Schemas.Email

    timestamps()
  end

  def changeset(%ClientEmail{} = client_email, attrs) do
    client_email
    |> cast(attrs, [:email_id, :client_id])
    |> cast_assoc(:email)
    |> assoc_constraint(:client)
    |> assoc_constraint(:email)
  end
end
