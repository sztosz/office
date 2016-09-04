defmodule Office.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :address, :string
      add :nip, :bigint
      add :regon, :bigint
      add :krs, :bigint
      add :emails, {:array, :map}
      add :phones, {:array, :map}

      timestamps()
    end

  end
end
