defmodule Office.Web.LayoutView do
  use Office.Web, :view

  def set_lang(conn, lang) do
    conn.request_path <> "?locale=#{lang}"
  end
end
