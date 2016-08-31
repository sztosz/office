defmodule Office.Repo.Migrations.CreateClient do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :email, :string
      add :phone, :integer
      add :address, :string
      add :nip, :integer
      add :regon, :integer
      add :krs, :integer

      timestamps()
    end

  end
end
