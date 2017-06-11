defmodule Office.Litigation.Schemas.Phone do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :phone, :integer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:phone])
  end
end
