defmodule EctoYaml do
  @behaviour Ecto.Type

  def type, do: :string

  # Map, List and valid Yaml strings are allowed.
  def cast(string) when is_binary(string), do: parse_yaml(string)
  def cast(map) when is_map(map), do: {:ok, map}
  def cast(list) when is_list(list), do: {:ok, list}
  def cast(_), do: :error

  def load(string) when is_binary(string), do: parse_yaml(string)

  def dump(map_or_list) when is_map(map_or_list) or is_list(map_or_list) do
    case Poison.encode(map_or_list) do
      {:ok, encoded} -> {:ok, "---\n" <> encoded}
    end
  end
  def dump(_), do: :error

  defp parse_yaml(string) do
    try do
      yaml = YamlElixir.read_from_string(string)
      {:ok, yaml}
    catch
      _ -> :error
    end
  end
end
