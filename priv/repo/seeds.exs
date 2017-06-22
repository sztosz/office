# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Office.Repo.insert!(%Office.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Comeonin.Bcrypt

alias Office.Repo

alias Office.Litigation.Schemas.Address
alias Office.Litigation.Schemas.Client
alias Office.Litigation.Schemas.Phone
alias Office.Litigation.Schemas.Email
alias Office.Litigation.Schemas.ClientsPhones
alias Office.Litigation.Schemas.ClientsEmails
alias Office.Litigation.Schemas.Court
alias Office.Litigation.Schemas.Department
alias Office.Litigation.Schemas.Case
alias Office.Litigation.Schemas.Hearing


defmodule SeedHelp do
  def create_admin(login, pass) do
    Repo.insert!(
      %Office.Auth.Schemas.User{
        name: login,
        username: login,
        password_hash: Bcrypt.hashpwsalt(pass)
      }
    )
  end

  def address do
    Repo.insert!(
      %Address{
        zip: Faker.Address.zip,
        town: Faker.Address.city,
        street: Faker.Address.street_name
      }
    )
  end

  def phone do
   Repo.insert!(%Phone{phone: Enum.random(1_000_000_000..9_999_999_999) |> Integer.to_string})
   end

  def email do
    Repo.insert!(%Email{email: Faker.Internet.email})
  end
end

Faker.start

# Inserting clients
clients =
  for _ <- 1..30 do
    client = Repo.insert!(
      %Client{
        name: Faker.Name.first_name,
        surname: Faker.Name.last_name,
        company: Faker.Company.name,
        address: SeedHelp.address(),
        nip: Enum.random(1_000_000_000..9_999_999_999) |> Integer.to_string,
        krs: Enum.random(1_000_000_000..9_999_999_999) |> Integer.to_string,
        }
    )
    for _ <- 1..:rand.uniform(5) do
      Repo.insert!(%ClientsPhones{phone: SeedHelp.phone, client: client})
    end
    for _ <- 1..:rand.uniform(5) do
      Repo.insert!(%ClientsEmails{email: SeedHelp.email, client: client})
    end
    client
  end

# Inserting courts with departaments
courts =
  for _ <- 1..10 do
    address = SeedHelp.address()

    Repo.insert!(
      %Court{
        name: "SĄD OKRĘGOWY W #{address.town}",
        address: address,
        phone: SeedHelp.phone,
        departments: [
          %Department{name: Faker.Company.name, address: address, phone: SeedHelp.phone, email: SeedHelp.email},
          %Department{name: Faker.Company.name, address: address, phone: SeedHelp.phone, email: SeedHelp.email},
          %Department{name: Faker.Company.name, address: address, phone: SeedHelp.phone, email: SeedHelp.email},
        ]}
      )
  end

# Insert some cases
cases =
  for i <- 1..20 do
    %Case{}
    |> Ecto.Changeset.change(signature: Faker.Company.bullshit, kind: Enum.random(CaseKindsEnum.__enum_map__), value: :rand.uniform * 100)
    |> Ecto.Changeset.put_assoc(:plaintiff, clients |> Enum.at(i))
    |> Ecto.Changeset.put_assoc(:defendant, clients |> Enum.at(i + 10))
    |> Ecto.Changeset.put_assoc(:department, Enum.random(courts).departments |> Enum.random)
    |> Repo.insert!
  end

for i <- 1..20 do
  date = DateTime.utc_now |> DateTime.to_unix
  date = date + Enum.random(10_000..99_999) |> DateTime.from_unix!
  courtroom = Enum.random(0..999)
  summoned = Faker.Name.first_name <> " " <> Faker.Name.last_name
  %Hearing{}
  |> Ecto.Changeset.change(date: date, courtroom: courtroom, summoned: summoned)
  |> Ecto.Changeset.put_assoc(:case, cases |> Enum.random )
end


SeedHelp.create_admin("admin", "admin")
