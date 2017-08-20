defmodule Office.Litigation.Schemas.Phone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Phone

  schema "phones" do
    field :number, :string

    timestamps()
  end

  def changeset(%Phone{} = phone, params \\ %{}) do
    phone
    |> cast(params, [:number])
    |> validate_required([:number])
  end
end
