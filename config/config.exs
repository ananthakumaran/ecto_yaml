use Mix.Config

config :ecto_yaml, EctoYaml.TestRepo,
  adapter: Ecto.Adapters.MyXQL,
  database: "ecto_yaml",
  username: "root",
  password: System.get_env("SQL_PASSWORD", "sqlsecret"),
  hostname: "localhost"
