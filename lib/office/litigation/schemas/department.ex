defmodule Office.Litigation.Schemas.Department do
  use Ecto.Schema

  import Ecto.Changeset

  schema "departments" do
    field :name, :string
    belongs_to :court, Office.Litigation.Schemas.Court
    has_many :cases, Office.Litigation.Schemas.Case

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :court_id])
    |> validate_required([:name, :court_id])
  end
end
