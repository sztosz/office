defmodule Office.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :zip, :string, null: false
      add :town, :string, null: false
      add :street, :string, null: false

      timestamps()
    end

  end
end
