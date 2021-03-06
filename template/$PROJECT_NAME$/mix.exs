defmodule <%= @project_name_camel_case %>.Mixfile do
  use Mix.Project

  def project do
    [app: :<%= @project_name %>,
     version: "0.0.1",
     elixir: "~> 1.5",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {<%= @project_name_camel_case %>.Application, []},
     extra_applications: [:logger, :runtime_tools<%= if @is_heroku? do %>, :scout_apm <% end %>]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:canada, "~> 1.0.1"},
     {:canary, "~> 1.1.0"},
     {:comeonin, "~> 3.0.0"},
     {:cowboy, "~> 1.0"},
     {:gettext, "~> 0.11"},
     {:guardian, "~> 0.14.4"},
     {:phoenix, "~> 1.3.0-rc", override: true},
     {:phoenix_ecto, "~> 3.2"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_slime, "~> 0.9.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:postgrex, ">= 0.0.0"},
     <%= if @is_heroku? do %>
     {:scout_apm, "~> 0.0"},
     <%= end %>

     {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "s": ["phx.server"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
