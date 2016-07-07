ExUnit.start()

alias EctoYaml.TestRepo

db_config = [
  adapter: Ecto.Adapters.MySQL,
  database: "ecto_yaml",
  username: "root",
  password: "sqlsecret",
  hostname: "localhost"
]
Application.put_env(:ecto_yaml, TestRepo, db_config)

defmodule EctoYaml.TestRepo do
  use Ecto.Repo, otp_app: :ecto_yaml
end

_   = Ecto.Adapters.MySQL.storage_down(db_config)
:ok = Ecto.Adapters.MySQL.storage_up(db_config)

{:ok, _pid} = TestRepo.start_link

defmodule EctoYaml.Migration do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :history, :text
    end
  end
end


Ecto.Migration.Supervisor.start_link
:ok = Ecto.Migrator.up(TestRepo, 0, EctoYaml.Migration, log: false)
Process.flag(:trap_exit, true)
