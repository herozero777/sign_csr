# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sign_csr,
  ecto_repos: [SignCsr.Repo]

# Configures the endpoint
config :sign_csr, SignCsrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WmTPn6fMuwyYKP6/2NGy76AIXp26lAOots3JH375ffSuQcnIl534qItlEgaN6Z0m",
  render_errors: [view: SignCsrWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SignCsr.PubSub,
  live_view: [signing_salt: "7eU8kFp3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
