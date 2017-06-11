defmodule Office.Litigation.Schemas.Case do
  use Ecto.Schema

  import Ecto.Changeset

  schema "cases" do
    field :signature, :string
    field :kind, CaseKindsEnum
    belongs_to :plaintiff, Office.Client
    belongs_to :defendant, Office.Client
    belongs_to :department, Office.Department

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:signature, :plaintiff_id, :defendant_id, :department_id, :kind])
    |> validate_required([:signature, :plaintiff_id, :defendant_id, :department_id, :kind])
  end
end
