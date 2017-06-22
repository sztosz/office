defmodule Office.Litigation.Schemas.Hearing do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Hearing

  schema "hearings" do
    field :date, :naive_datetime
    field :courtroom, :string
    field :summoned, :string
    belongs_to :case, Office.Litigation.Schemas.Case

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Hearing{} = hearing, params \\ %{}) do
    hearing
    |> cast(params, [:date, :courtroom, :summoned, :case_id])
    |> validate_required([:date, :case_id])
  end
end
