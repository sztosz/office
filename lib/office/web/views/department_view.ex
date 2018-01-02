defmodule OfficeWeb.DepartmentView do
  use OfficeWeb, :view

  def human_date_time(date_time) do
    Enum.join([date_time.day, "/", date_time.month, "/", date_time.year, " ", date_time.hour, ":", date_time.minute])
  end
end
