# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zz,
  ecto_repos: [Zz.Repo]

# Configures the endpoint
config :zz, ZzWeb.Endpoint,
  instrumenters: [NewRelic.Phoenix.Instrumenter],
  url: [host: "localhost"],
  secret_key_base: "J3PfB9f7whrKsDM8Ohitdj2zrdfaqseVW5wPxA24Dx2wJZ6T6sUH68Va5N0MDjSh",
  render_errors: [view: ZzWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Zz.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :zz, Zz.Scheduler,
  jobs: [
    {"0 0-23/1 * * *", {Zz.GetImage, :n, []}},
    {"0 4 * * *", {Zz.Task, :run, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
config :new_relic_agent,
  app_name: "You",
  license_key: "ee9c2eabf9a8054364cfc885b768dc549c1ee5c6"

import_config "#{Mix.env()}.exs"
