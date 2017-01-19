defmodule Office.Phone do
  use Office.Web, :model

  embedded_schema do
    field :phone, :integer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:phone])
  end
end
