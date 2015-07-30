use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :apiv2, Apiv2.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :apiv2, Apiv2.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "simwms_test",
  size: 1 # Use a single connection for transactional tests
