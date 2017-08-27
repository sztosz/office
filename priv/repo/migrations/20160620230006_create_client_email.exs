defmodule Office.Repo.Migrations.CreateClientEmail do
  use Ecto.Migration

  def change do
    create table(:clients_emails) do
      add :client_id, references(:clients, on_delete: :delete_all), null: false
      add :email_id, references(:emails, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
