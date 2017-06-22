defmodule Office.Litigation.Schemas.Email do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Email

  schema "emails" do
    field :email, :string

    timestamps()
  end

  def changeset(%Email{} = email, attrs) do
    email
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
