defmodule Office.Repo.Migrations.CreateCourt do
  use Ecto.Migration

  def change do
    create table(:courts) do
      add :name, :string, null: false
      add :phone_id, references(:phones, on_delete: :nothing)
      add :address_id, references(:addresses, on_delete: :nothing), null: false

      timestamps()
    end

  end
end
