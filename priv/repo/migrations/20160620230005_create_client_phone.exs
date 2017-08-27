defmodule Office.Repo.Migrations.CreateClientPhone do
  use Ecto.Migration

  def change do
    create table(:clients_phones) do
      add :client_id, references(:clients, on_delete: :delete_all), null: false
      add :phone_id, references(:phones, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
