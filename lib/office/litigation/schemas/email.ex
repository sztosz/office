defmodule Office.Litigation.Schemas.Email do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Email

  schema "emails" do
    field :address, :string

    timestamps()
  end

  def changeset(%Email{} = email, params \\ %{}) do
    email
    |> cast(params, [:address])
    |> validate_required([:address])
  end
end
