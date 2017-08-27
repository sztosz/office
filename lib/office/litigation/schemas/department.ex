defmodule Office.Litigation.Schemas.Department do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Department

  schema "departments" do
    field :name, :string
    belongs_to :court, Office.Litigation.Schemas.Court
    belongs_to :address, Office.Litigation.Schemas.Address
    belongs_to :email, Office.Litigation.Schemas.Email
    belongs_to :phone, Office.Litigation.Schemas.Phone
    has_many :cases, Office.Litigation.Schemas.Case
    has_many :hearings, through: [:cases, :hearings]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Department{} = deparment, params \\ %{}) do
    deparment
    |> cast(params, [:name, :court_id])
    |> validate_required([:name, :court_id])
    |> cast_assoc(:court)
    |> cast_assoc(:address)
    |> cast_assoc(:email)
    |> cast_assoc(:phone)
  end
end
