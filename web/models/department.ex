defmodule Office.Department do
  use Office.Web, :model

  schema "departments" do
    field :name, :string
    belongs_to :court, Office.Court

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
