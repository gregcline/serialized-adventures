use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :serialized_adventures, SerializedAdventuresWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :serialized_adventures, SerializedAdventures.Repo,
  username: "postgres",
  password: "postgres",
  database: "serialized_adventures_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
