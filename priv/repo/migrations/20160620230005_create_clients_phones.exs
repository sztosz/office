defmodule Office.Repo.Migrations.CreateClientsPhones do
  use Ecto.Migration

  def change do
    create table(:clients_phones) do
      add :client_id, references(:clients, on_delete: :nothing), null: false
      add :phone_id, references(:phones, on_delete: :nothing), null: false

      timestamps()
    end

  end
end
