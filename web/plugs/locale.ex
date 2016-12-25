defmodule Office.Plugs.Locale do
  import Plug.Conn

  def init(_opts) do
    nil
  end

  def call(conn, _opts) do
    case conn.params["locale"] || get_session(conn, :locale) do
      nil -> conn
      locale ->
        Gettext.put_locale(Office.Gettext, locale)
        put_session(conn, :locale, locale)
    end
  end
end
