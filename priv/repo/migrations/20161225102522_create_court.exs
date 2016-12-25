defmodule Office.Repo.Migrations.CreateCourt do
  use Ecto.Migration

  def change do
    create table(:courts) do
      add :name, :string
      add :city, :string
      add :street, :string
      add :zip, :string
      add :phone, :integer

      timestamps()
    end

  end
end
