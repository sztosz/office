defmodule Office.Litigation.Schemas.ClientPhone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.ClientPhone

  schema "clients_phones" do
    belongs_to :client, Office.Litigation.Schemas.Client
    belongs_to :phone, Office.Litigation.Schemas.Phone

    timestamps()
  end

  def changeset(%ClientPhone{} = client_phone, attrs) do
    client_phone
    |> cast(attrs, [:phone_id, :client_id])
    |> cast_assoc(:phone)
    |> assoc_constraint(:client)
    |> assoc_constraint(:phone)
  end
end
