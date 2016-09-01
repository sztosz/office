defmodule Office.Repo.Migrations.AddSurnameAndCompanyToClients do
  use Ecto.Migration

  def change do
    alter table(:clients) do
      add :surname, :string
      add :company, :string
    end
  end
end
