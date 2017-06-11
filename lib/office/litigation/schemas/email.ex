defmodule Office.Litigation.Schemas.Email do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :email, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
  end
end
