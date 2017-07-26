use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# <%= @project_name_camel_case %>Web.Endpoint.load_from_system_env/1 dynamically.
# Any dynamic configuration should be moved to such function.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phoenix.digest task
# which you typically run after static files are built.
config :<%= @project_name %>, <%= @project_name_camel_case %>Web.Endpoint,
  on_init: {<%= @project_name_camel_case %>Web.Endpoint, :load_from_system_env, []},
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Configure your database
config :<%= @project_name %>, <%= @project_name_camel_case %>.Repo,
  adapter: Ecto.Adapters.Postgres,
  <%= if @is_heroku? do %>
  url: System.get_env("DATABASE_URL"),
  loggers: [{Ecto.LogEntry, :log, []},
            {ScoutApm.Instruments.EctoLogger, :log, []}],
  <% else %>
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: "<%= @project_name %>_prod",
  loggers: [{Ecto.LogEntry, :log, []}],
  <% end %>
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "15"),
  ssl: true

# Do not print debug messages in production
config :logger, level: :info

config :guardian, Guardian,
  allowed_algos: ["ES512"],
  secret_key: %{
    "crv" => "P-521",
    "d" => System.get_env("GUARDIAN_JWK_ES512_D"),
    "kty" => "EC",
    "x" => System.get_env("GUARDIAN_JWK_ES512_X"),
    "y" => System.get_env("GUARDIAN_JWK_ES512_Y")
  }

<%= if @is_heroku? do %>
# Import Scout APM
import_config "count_apm.exs"
<% end %>
