defmodule Office.Litigation.Schemas.ClientsEmails do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.ClientsEmails

  schema "clients_emails" do
    belongs_to :client, Office.Litigation.Schemas.Client
    belongs_to :email, Office.Litigation.Schemas.Email

    timestamps()
  end

  def changeset(%ClientsEmails{} = clients_emails, attrs) do
    clients_emails
    |> cast(attrs, [:email_id, :clinet_id])
    |> assoc_constraint(:client)
    |> cast_assoc(:email)
  end
end
