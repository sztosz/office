defmodule Office.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :signature, :string
      add :kind, :case_kind
      add :plaintiff_id, references(:clients)
      add :defendant_id, references(:clients)
      add :department_id, references(:departments)

      timestamps()
    end

  end
end
