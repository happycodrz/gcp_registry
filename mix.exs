defmodule GcpRegistry.MixProject do
  use Mix.Project

  def project do
    [
      app: :gcp_registry,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:jason, "~> 1.1"},

      # google cloud libs
      {:goth, "~> 1.0"},

      # test libs
      {:mimic, "~> 0.2", only: :test},
      {:cortex, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
