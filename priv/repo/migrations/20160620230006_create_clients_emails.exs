defmodule Office.Repo.Migrations.CreateClientsEmails do
  use Ecto.Migration

  def change do
    create table(:clients_emails) do
      add :client_id, references(:clients, on_delete: :nothing), null: false
      add :email_id, references(:emails, on_delete: :nothing), null: false

      timestamps()
    end

  end
end
