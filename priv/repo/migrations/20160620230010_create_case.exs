defmodule Office.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :signature, :string, null: false
      add :kind, :case_kind, null: false
      add :value, :float
      add :plaintiff_id, references(:clients)
      add :defendant_id, references(:clients)
      add :department_id, references(:departments), null: false

      timestamps()
    end
  end
end
