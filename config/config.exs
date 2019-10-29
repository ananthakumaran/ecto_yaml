use Mix.Config

config :ecto_yaml, EctoYaml.TestRepo,
  adapter: Ecto.Adapters.MyXQL,
  database: "ecto_yaml",
  username: "root",
  password: "sqlsecret",
  hostname: "localhost"
