defmodule Office.Litigation.Schemas.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias Office.Litigation.Schemas.Client

  schema "clients" do
    field :name, :string
    field :surname, :string
    field :company, :string
    field :nip, :string
    field :krs, :string
    has_many :clients_emails, Office.Litigation.Schemas.ClientEmail
    has_many :emails, through: [:clients_emails, :email]
    has_many :clients_phones, Office.Litigation.Schemas.ClientPhone
    has_many :phones, through: [:clients_phones, :phone]
    has_many :plaintiff_cases, Office.Litigation.Schemas.Department
    has_many :defendant_cases, Office.Litigation.Schemas.Department
    belongs_to :address, Office.Litigation.Schemas.Address

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%Client{} = client, params \\ %{}) do
    client
    |> cast(params, [:name, :surname, :company, :nip, :krs])
    |> cast_assoc(:address)

  end
end
