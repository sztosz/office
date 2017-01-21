defmodule Office.Case do
  use Office.Web, :model

  schema "cases" do
    field :signature, :string
    field :kind, CaseEnum
    belongs_to :plaintiff, Office.Client
    belongs_to :defendant, Office.Client
    belongs_to :department, Office.Deapartment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:signature])
    |> validate_required([:signature])
  end
end
