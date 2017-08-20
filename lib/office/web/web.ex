defmodule OfficeWeb do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use OfficeWeb, :controller
      use OfficeWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: OfficeWeb

      import Plug.Conn

      alias OfficeWeb.Plugs.Authorization

      import OfficeWeb.Router.Helpers
      import OfficeWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/office/web/templates", namespace: OfficeWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import OfficeWeb.Router.Helpers
      import OfficeWeb.ErrorHelpers
      import OfficeWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Office.Repo
      import Ecto
      import Ecto.Query
      import OfficeWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
