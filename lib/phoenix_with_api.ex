defmodule PhoenixWithApi do

  @moduledoc File.read!(Path.join([__DIR__, "../README.md"]))

  use MixTemplates,
    name:       :phoenix_with_api,
    short_desc: "Template for ....",
    source_dir: "../template",
    options: [
      heroku: [ to: :is_heroku?, default: false ],
      travis_ci: [ to: :is_travis?, default: false ]
    ]

end
