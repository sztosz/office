defmodule Office.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :signature, :string, null: false
      add :kind, :case_kind, null: false
      add :value, :float
      add :plaintiff_id, references(:clients, on_delete: :nothing), null: false
      add :defendant_id, references(:clients, on_delete: :nothing), null: false
      add :department_id, references(:departments, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
