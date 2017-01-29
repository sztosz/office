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
alias Office.Client
alias Office.Email
alias Office.Phone
alias Office.Court
alias Office.Department
alias Office.Case
alias Office.Repo

defmodule SeedHelp do
  def rand_10_int do
    {int, _} = Integer.parse(Faker.Code.isbn10)
    int
  end

  def create_admin(login, pass) do
    Repo.insert!(
      %Office.User{
        name: login,
        username: login,
        password_hash: Comeonin.Bcrypt.hashpwsalt(pass)
      }
    )
  end
end

Faker.start

# Inserting clients
clients =
  for _ <- 0..30 do
    Repo.insert!(
      %Client{
        name: Faker.Name.first_name,
        surname: Faker.Name.last_name,
        company: Faker.Company.name,
        address: Faker.Address.street_address(true),
        nip: SeedHelp.rand_10_int,
        regon: SeedHelp.rand_10_int,
        krs: SeedHelp.rand_10_int,
        phones: [
          %Phone{phone: SeedHelp.rand_10_int},
          %Phone{phone: SeedHelp.rand_10_int},
          %Phone{phone: SeedHelp.rand_10_int}
        ],
        emails: [
          %Email{email: Faker.Internet.email},
          %Email{email: Faker.Internet.email},
          %Email{email: Faker.Internet.email}
        ]}
    )
end

# Inserting courts with departaments
courts =
  for _ <- 0..10 do
    city = Faker.Address.city()

    Repo.insert!(
      %Court{
        name: "COURT #{city}",
        city: city,
        street: Faker.Address.street_address(),
        zip: Faker.Address.zip_code(),
        phone: SeedHelp.rand_10_int(),
        departments: [
          %Department{name: Faker.Company.name},
          %Department{name: Faker.Company.name},
          %Department{name: Faker.Company.name}
        ]}
    )
end

# Insert some cases
for i <- 0..10 do
  kind = if (:erlang.rem(i, 2) == 0), do: :civil, else: :criminal
  plaintiff = Enum.at(clients, i)
  defendant = Enum.at(clients, i + 1)
  court = Enum.at(courts, i)
  department = Enum.at(court.departments, 1)
  case = Ecto.Changeset.change(%Case{}, signature: Faker.Company.bullshit, kind: kind)
  case = Ecto.Changeset.put_assoc(case, :plaintiff, plaintiff)
  case = Ecto.Changeset.put_assoc(case, :defendant, defendant)
  case = Ecto.Changeset.put_assoc(case, :department, department)
  Repo.insert!(case)
end

SeedHelp.create_admin("admin", "admin")