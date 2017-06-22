defmodule Office.Litigation.Schemas.Phone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Phone

  schema "phones" do
    field :phone, :string

    timestamps()
  end

  def changeset(%Phone{} = phone, attrs) do
    phone
    |> cast(attrs, [:phone])
    |> validate_required([:phone])
  end
end
