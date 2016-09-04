defmodule Office.Client do
  use Office.Web, :model

  schema "clients" do
    field :name, :string
    field :surname, :string
    field :company, :string
    field :address, :string
    field :nip, :integer
    field :regon, :integer
    field :krs, :integer
    embeds_many :emails, Office.Email
    embeds_many :phones, Office.Phone

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :surname, :company, :address, :nip, :regon, :krs])
    |> validate_required([:name, :surname])
    |> cast_embed(:emails)
    |> cast_embed(:phones, required: true)
  end
end
