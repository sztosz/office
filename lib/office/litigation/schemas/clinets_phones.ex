defmodule Office.Litigation.Schemas.ClientsPhones do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.ClientsPhones

  schema "clients_phones" do
    belongs_to :client, Office.Litigation.Schemas.Client
    belongs_to :phone, Office.Litigation.Schemas.Phone

    timestamps()
  end

  def changeset(%ClientsPhones{} = clients_phones, attrs) do
    clients_phones
#    |> cast(attrs, [:phone])
    |> assoc_constraint(:client)
    |> cast_assoc(:phone)
  end
end
