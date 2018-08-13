defmodule EctoYaml.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ecto_yaml,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger, :yaml_elixir]]
  end

  defp deps do
    [
      {:ecto, "~> 2.0"},
      {:yaml_elixir, "~> 2.0"},
      {:poison, "~> 2.0"},
      {:mariaex, "~> 0.7", only: :test}
    ]
  end
end
