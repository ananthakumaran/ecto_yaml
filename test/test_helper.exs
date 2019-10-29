ExUnit.start()

for app <- [:ecto, :ecto_sql] do
  {:ok, _} = Application.ensure_all_started(app)
end

db_config = Application.get_env(:ecto_yaml, EctoYaml.TestRepo)
_ = Ecto.Adapters.MyXQL.storage_down(db_config)
:ok = Ecto.Adapters.MyXQL.storage_up(db_config)

{:ok, _pid} = EctoYaml.TestRepo.start_link()

defmodule EctoYaml.Migration do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:history, :text)
    end
  end
end

:ok = Ecto.Migrator.up(EctoYaml.TestRepo, 0, EctoYaml.Migration, log: false)
Process.flag(:trap_exit, true)
