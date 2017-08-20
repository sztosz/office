defmodule OfficeWeb.PageController do
  use OfficeWeb, :controller

#  plug :authenticate_user

  def index(conn, _params) do
    render conn, "index.html"
  end
end
