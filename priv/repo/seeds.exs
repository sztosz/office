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
alias Office.Repo

defmodule SeedHelp do
  def rand_10_int do
    {int, rem} = Integer.parse(Faker.Code.isbn10)
    int
  end
end

Faker.start

for n <- 1..30 do
  Repo.insert!(%Client{
    name: Faker.Name.first_name,
    surname: Faker.Name.last_name,
    company: Faker.Company.name,
    address: Faker.Address.street_address(true),
    nip: SeedHelp.rand_10_int,
    regon: SeedHelp.rand_10_int,
    krs: SeedHelp.rand_10_int,
    phones: [%Phone{phone: SeedHelp.rand_10_int}, %Phone{phone: SeedHelp.rand_10_int}],
    emails: [%Email{email: Faker.Internet.email}, %Email{email: Faker.Internet.email}]})
end
