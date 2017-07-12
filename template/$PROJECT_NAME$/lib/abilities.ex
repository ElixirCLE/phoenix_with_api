defimpl Canada.Can, for: <%= @project_name_camel_case %>.Account.User do
  alias <%= @project_name_camel_case %>.Account.User

  def can?(%User{admin: true}, _, _), do: true

  def can?(%User{id: user_id}, action, %User{id: user_id})
    when action in [:edit, :update, :delete], do: true

  def can?(%User{}, _, _), do: false
end

