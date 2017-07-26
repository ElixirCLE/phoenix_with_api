defmodule <%= @project_name_camel_case %>.Plug.EditAuthenticate do
  alias <%= @project_name_camel_case %>.{Repo, Account.User}
  import Plug.Conn

  @moduledoc ""

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    assign_current_user(conn)
  end

  defp assign_current_user(%Plug.Conn{} = conn) do
    current_user = Guardian.Plug.current_resource(conn)
    assign_current_user(conn, current_user)
  end
  defp assign_current_user(conn, %User{} = user) do
    # Reload the current user from the database to pick up any changes
    user = Repo.get(User, user.id)
    assign(conn, :current_user, user)
  end
end

