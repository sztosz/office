defmodule Office.Email do
  use Office.Web, :model

  embedded_schema do
    field :email

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
  end
end
