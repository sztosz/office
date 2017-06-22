defmodule Office.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :surname, :string
      add :company, :string
      add :nip, :string
      add :krs, :string
      add :address_id, references(:addresses, on_delete: :nothing)

      timestamps()
    end

  end
end
