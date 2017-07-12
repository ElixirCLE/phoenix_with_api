# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     <%= @project_name_camel_case %>.Repo.insert!(%<%= @project_name_camel_case %>.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias <%= @project_name_camel_case %>.Account.User

<%= @project_name_camel_case %>.Repo.insert!(
  %User{
    email: "admin@<%= @project_name %>.com",
    name: "Admin",
    password_hash: Comeonin.Bcrypt.hashpwsalt("admin1"),
    admin: true
  }
)
