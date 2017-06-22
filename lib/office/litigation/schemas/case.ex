defmodule Office.Litigation.Schemas.Case do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Case

  schema "cases" do
    field :signature, :string
    field :kind, CaseKindsEnum
    field :value, :float
    belongs_to :plaintiff, Office.Litigation.Schemas.Client
    belongs_to :defendant, Office.Litigation.Schemas.Client
    belongs_to :department, Office.Litigation.Schemas.Department
    has_many :hearings, Office.Litigation.Schemas.Hearing

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Case{} = case, params \\ %{}) do
    case
    |> cast(params, [:signature, :kind, :value, :plaintiff_id, :defendant_id, :department_id])
    |> validate_required([:signature, :kind, :department_id])
  end
end
