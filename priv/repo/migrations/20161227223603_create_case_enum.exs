defmodule Office.Repo.Migrations.CreateCase do
  use Ecto.Migration

  def up do
    CaseEnum.create_type
    create table(:cases_pg) do
      add :kind, :kind
    end
  end

  def down do
    drop table(:casess_pg)
    CaseEnum.drop_type
  end
end
