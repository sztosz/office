defmodule Office.Repo.Migrations.CreateOffice.Office.Litigation.Schemas.Email do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :email, :string, null: false

      timestamps()
    end

  end
end
