defmodule Office.Repo.Migrations.CreateCaseEnum do
  use Ecto.Migration

  def up do
    CaseKindsEnum.create_type
    create table(:cases_pg) do
      add :case_kind, :case_kind
    end
  end

  def down do
    drop table(:casess_pg)
    CaseKindsEnum.drop_type
  end
end
