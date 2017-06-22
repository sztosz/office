defmodule Office.Litigation.Schemas.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Address

  schema "addresses" do
    field :zip, :string
    field :town, :string
    field :street, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Address{} = address, params \\ %{}) do
    address
    |> cast(params, [:zip, :town, :street])
    |> validate_required([:zip, :town, :street])
  end
end
