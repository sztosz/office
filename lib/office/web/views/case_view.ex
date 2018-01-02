defmodule OfficeWeb.CaseView do
  use OfficeWeb, :view

  def clients_option(clients) do
    Enum.map(clients, &{&1.name, &1.id})
  end

  def departments_option(departments) do
    Enum.map(departments, &{&1.name, &1.id})
  end

  def human_date_time(date_time) do
    Enum.join([date_time.day, "/", date_time.month, "/", date_time.year, " ", date_time.hour, ":", date_time.minute])
  end
end
