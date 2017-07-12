defmodule <%= @project_name_camel_case %>.Web.Router do
  use <%= @project_name_camel_case %>.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureResource
  end

  pipeline :edit_authenticate do
    plug Guardian.Plug.EnsureAuthenticated, handler: <%= @project_name_camel_case %>.GuardianErrorHandler
    plug <%= @project_name_camel_case %>.Plug.EditAuthenticate
  end

  pipeline :view_authenticate do
    plug <%= @project_name_camel_case %>.Plug.ViewAuthenticate
  end

  scope "/", <%= @project_name_camel_case %>.Web do
    pipe_through :browser # Use the default browser stack

    resources "/registrations", RegistrationController, only: [:create, :new]
    resources "/login", SessionController, only: [:create, :new]
  end

  scope "/", <%= @project_name_camel_case %>.Web do
    pipe_through [:browser, :browser_auth, :view_authenticate]
  end

  scope "/", <%= @project_name_camel_case %>.Web do
    pipe_through [:browser, :browser_auth, :edit_authenticate]

    get "/", PageController, :index

    resources "/user", UserController, only: [:edit, :update]

    delete "/logout", SessionController, :delete
  end

  scope "/api", <%= @project_name_camel_case %>.Web do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create, as: :api_registration
      resources "/sessions", SessionController, only: [:create, :new], as: :api_session
      delete "/sessions", SessionController, :delete, as: :api_session
    end

    scope "/v1" do
      pipe_through :api_auth
    end
  end
end
