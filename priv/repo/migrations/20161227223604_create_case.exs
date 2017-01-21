defmodule Office.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def change do
    create table(:cases) do
      add :signature, :string
      add :plaintiff_id, references(:clients)
      add :defendant_id, references(:clients)
      add :court_id, references(:courts)
      add :department_id, references(:departments)

      timestamps()
    end

  end
end
