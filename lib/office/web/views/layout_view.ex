defmodule OfficeWeb.LayoutView do
  use OfficeWeb, :view

  def set_lang(conn, lang) do
    conn.request_path <> "?locale=#{lang}"
  end
end
