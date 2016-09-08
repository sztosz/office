defmodule Office.PageController do
  use Office.Web, :controller

  plug :authenticate_user

  def index(conn, _params) do
    render conn, "index.html"
  end
end
