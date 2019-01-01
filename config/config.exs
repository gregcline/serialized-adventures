# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :serialized_adventures,
  ecto_repos: [SerializedAdventures.Repo]

# Configures the endpoint
config :serialized_adventures, SerializedAdventuresWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HdVyGnrBCmsyhgqxdkLLaj2fjok3wFffr76VBvIOatztd+15+pyV9mBaYV75Ly0+",
  render_errors: [view: SerializedAdventuresWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SerializedAdventures.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
  storage: Arc.Storage.GCS,
  bucket: "serialized-adventures"

# config :goth,
#   json: "config/gcs_credentials.json" |> Path.expand |> File.read!

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
