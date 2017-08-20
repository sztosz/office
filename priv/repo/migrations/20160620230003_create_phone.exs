defmodule Office.Repo.Migrations.CreateOffice.Office.Litigation.Schemas.Phone do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :number, :string, null: false

      timestamps()
    end

  end
end
