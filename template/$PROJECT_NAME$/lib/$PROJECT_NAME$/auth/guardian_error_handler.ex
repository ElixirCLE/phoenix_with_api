defmodule <%= @project_name_camel_case %>.GuardianErrorHandler do
  import <%= @project_name_camel_case %>.Web.Router.Helpers

  @moduledoc ""

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.put_flash(:error, "You must be logged in to do that")
    |> Phoenix.Controller.redirect(to: session_path(conn, :new))
  end
end
