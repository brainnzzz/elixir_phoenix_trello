# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trello,
  ecto_repos: [Trello.Repo]

# Configures the endpoint
config :trello, TrelloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UggiTNkHT9IfY18ZSsVT6R4r6Jw6On/W643FNdIU5bkMFMYn5pjFrrFVsrp64w+Q",
  render_errors: [view: TrelloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Trello.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "TrelloWeb",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "UggiTNkHT9IfY18ZSsVT6R4r6Jw6On",
  serializer: Trello.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
