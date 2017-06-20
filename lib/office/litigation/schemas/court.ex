defmodule Office.Litigation.Schemas.Court do
  use Ecto.Schema

  import Ecto.Changeset

  schema "courts" do
    field :name, :string
    field :city, :string
    field :street, :string
    field :zip, :string
    field :phone, :integer
    has_many :departments, Office.Litigation.Schemas.Department
    has_many :cases, through: [:departments, :cases]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :city, :street, :zip, :phone])
    |> validate_required([:name, :city, :street, :zip, :phone])
  end
end
