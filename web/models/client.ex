defmodule Office.Client do
  use Office.Web, :model

  schema "clients" do
    field :name, :string
    field :email, :string
    field :phone, :integer
    field :address, :string
    field :nip, :integer
    field :regon, :integer
    field :krs, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :phone, :address, :nip, :regon, :krs])
    |> validate_required([:name, :email, :phone, :address, :nip, :regon, :krs])
  end
end
