defmodule <%= @project_name_camel_case %>Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use <%= @project_name_camel_case %>Web, :controller
      use <%= @project_name_camel_case %>Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: <%= @project_name_camel_case %>Web
      <%= if @is_heroku? do %>
      use ScoutApm.Instrumentation
      <% end %>
      import Plug.Conn
      import <%= @project_name_camel_case %>Web.Router.Helpers
      import <%= @project_name_camel_case %>Web.Gettext

      import Canary.Plugs
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/<%= @project_name %>_web/templates",
                        namespace: <%= @project_name_camel_case %>Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import <%= @project_name_camel_case %>Web.Router.Helpers
      import <%= @project_name_camel_case %>Web.ErrorHelpers
      import <%= @project_name_camel_case %>Web.Gettext

      import <%= @project_name_camel_case %>.Account.Session, only: [current_user: 1, logged_in?: 1]
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import <%= @project_name_camel_case %>Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
