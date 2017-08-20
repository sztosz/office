defmodule Office.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false, unique: true
      add :password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
