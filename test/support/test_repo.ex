defmodule EctoYaml.TestRepo do
  use Ecto.Repo, otp_app: :ecto_yaml, adapter: Ecto.Adapters.MyXQL
end
