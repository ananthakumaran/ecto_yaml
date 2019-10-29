defmodule EctoYaml.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ecto_yaml,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [applications: [:logger, :yaml_elixir]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ecto, "~> 2.0 or ~> 3.0"},
      {:yaml_elixir, "~> 2.0"},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:myxql, ">= 0.0.0", only: :test},
      {:ecto_sql, "~> 3.0", only: :test}
    ]
  end
end
