defmodule Office.Repo.Migrations.CreateDepartment do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :name, :string, null: false
      add :court_id, references(:courts, on_delete: :nothing), null: false
      add :address_id, references(:addresses, on_delete: :nothing), null: false
      add :email_id, references(:emails, on_delete: :nothing)
      add :phone_id, references(:phones, on_delete: :nothing)

      timestamps()
    end
    create index(:departments, [:court_id])

  end
end
