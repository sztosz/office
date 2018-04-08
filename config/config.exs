# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :office, ecto_repos: [Office.Repo]

# Configures the endpoint
config :office, OfficeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q626bzls07wSwyPiDRQjOSt/mt8PQmuist8bwy1wUEpnQzPXJTorjSHrTJqinlOX",
  render_errors: [view: OfficeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OfficeWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    identity: {
      Ueberauth.Strategy.Identity,
      [
        callback_methods: ["POST"],
        uid_field: :email,
        nickname_field: :email,
        request_path: "/session/new",
        callback_path: "/session/identity/callback"
      ]
    }
  ]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Sztosz",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "a_secret_key",
  serializer: Office.Auth.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
