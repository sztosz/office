defmodule Office.Litigation.Schemas.Client do
  use Ecto.Schema

  import Ecto.Changeset

  schema "clients" do
    field :name, :string
    field :surname, :string
    field :company, :string
    field :address, :string
    field :nip, :integer
    field :regon, :integer
    field :krs, :integer
    embeds_many :emails, Office.Litigation.Schemas.Email
    embeds_many :phones, Office.Litigation.Schemas.Phone
    has_many :plaintiff_cases, Office.Litigation.Schemas.Department
    has_many :defendant_cases, Office.Litigation.Schemas.Department

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
