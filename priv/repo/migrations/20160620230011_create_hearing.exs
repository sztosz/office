defmodule Office.Repo.Migrations.CreateHearing do
  use Ecto.Migration

  def change do
    create table(:hearings) do
      add :date, :naive_datetime, null: false
      add :department_id, references(:departments, on_delete: :nothing), null: false
      add :courtroom, :string
      add :case_id, references(:cases, on_delete: :nothing), null: false
      add :summoned, :string

      timestamps()
    end
  end
end
