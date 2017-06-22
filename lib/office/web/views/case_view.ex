defmodule Office.Web.CaseView do
  use Office.Web, :view

  def clients_option(clients) do
    Enum.map(clients, &{&1.name, &1.id})
  end

  def departments_option(departments) do
    Enum.map(departments, &{&1.name, &1.id})
  end
end
