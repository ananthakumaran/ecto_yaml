defmodule EctoYamlTest do
  use ExUnit.Case

  import Ecto.Changeset

  defmodule UserOld do
    use Ecto.Schema

    schema "users" do
      field :history, :string
    end
  end

  defmodule User do
    use Ecto.Schema

    schema "users" do
      field :history, EctoYaml
    end
  end

  alias EctoYaml.TestRepo

  test "create" do
    user = TestRepo.insert!(%User{history: nil})
    user = TestRepo.get(User, user.id)
    assert user.history == nil

    user = TestRepo.insert!(%User{history: ["1", "2"]})
    user = TestRepo.get(User, user.id)
    assert user.history == ["1", "2"]

    user = TestRepo.insert!(%User{history: %{number: "1"}})
    user = TestRepo.get(User, user.id)
    assert user.history == %{"number" => "1"}

    user = TestRepo.insert!(%User{history: %{"number" => 1}})
    user = TestRepo.get(User, user.id)
    assert user.history == %{"number" => 1}

    assert_raise Ecto.ChangeError, fn ->
      TestRepo.insert!(%User{history: "---\n- hello\n- world"})
    end
  end

  test "cast" do
    assert_cast(["1", "2"], ["1", "2"])
    assert_cast(%{"number" => 1}, %{"number" => 1})
    assert_cast("---\n- hello\n- world", ["hello", "world"])

    yaml = """
---
- '{"no":1,"time":"2016-07-04T09:28:09.351Z","delivered":false,"reason":null,"exception_message":null}'
- '{"no":2,"time":"2016-07-04T09:28:27.504Z","delivered":false,"reason":null,"exception_message":null}'
"""
    decoded = [~s({"no":1,"time":"2016-07-04T09:28:09.351Z","delivered":false,"reason":null,"exception_message":null}), ~s({"no":2,"time":"2016-07-04T09:28:27.504Z","delivered":false,"reason":null,"exception_message":null})]

    assert_cast(yaml, decoded)

    user_old = TestRepo.insert!(%UserOld{history: yaml})
    user = TestRepo.get(User, user_old.id)
    assert user.history == decoded
  end

  defp assert_cast(raw, encoded) do
    %{changes: changes} = cast(%User{}, %{"history" => raw}, [:history], [])
    assert changes.history == encoded
  end
end
