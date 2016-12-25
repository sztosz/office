defmodule Office.Repo.Migrations.CreateDepartment do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :name, :string
      add :court_id, references(:courts, on_delete: :nothing)

      timestamps()
    end
    create index(:departments, [:court_id])

  end
end
