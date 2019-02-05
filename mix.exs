defmodule GcpRegistry.MixProject do
  use Mix.Project
  @version "0.1.0"
  def project do
    [
      app: :gcp_registry,
      version: @version,
      elixir: "~> 1.7 or ~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:construct, "~> 2.0"},
      {:table_rex, "~> 2.0", optional: true},

      # google cloud libs
      {:goth, "~> 1.0"},

      # test libs
      {:mimic, "~> 0.2", only: :test},
      {:cortex, "~> 0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Roman Heinrich"],
      licenses: ["MIT License"],
      description: "A lean client for  Google Cloud Container Registry (gcr.io)",
      links: %{
        Github: "https://github.com/happycodrz/gcp_registry",
        Docs: "http://hexdocs.pm/gcp_registry/#{@version}/"
      }
    ]
  end
end
