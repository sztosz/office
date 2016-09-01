defmodule Office.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :address, :string
      add :nip, :integer
      add :regon, :integer
      add :krs, :integer
      add :emails, {:array, :map}
      add :phones, {:array, :map}

      timestamps()
    end

  end
end
