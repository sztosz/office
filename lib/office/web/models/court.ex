defmodule Office.Court do
  use Office.Web, :model

  schema "courts" do
    field :name, :string
    field :city, :string
    field :street, :string
    field :zip, :string
    field :phone, :integer
    has_many :departments, Office.Department

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :city, :street, :zip, :phone])
    |> validate_required([:name, :city, :street, :zip, :phone])
  end
end
