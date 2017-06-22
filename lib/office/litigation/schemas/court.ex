defmodule Office.Litigation.Schemas.Court do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Court

  schema "courts" do
    field :name, :string
    belongs_to :phone, Office.Litigation.Schemas.Phone
    belongs_to :address, Office.Litigation.Schemas.Address
    has_many :departments, Office.Litigation.Schemas.Department
    has_many :cases, through: [:departments, :cases]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Court{} = court, params \\ %{}) do
    court
    |> cast(params, [:name])
    |> validate_required([:name])
    |> cast_assoc(:address)
    |> cast_assoc(:phone)
  end
end
