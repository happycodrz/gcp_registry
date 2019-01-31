defmodule GcpRegistry.GothInit do
  use Goth.Config

  @doc """
  central place for Goth config across all environments
  read from env with fallback on local file for development
  0. local: read from priv/gcp-config.json
  1. or mount on /var/run/secrets/goth/gcp-config.json
  2. env GCP_CONFIG_PATH -> read from this path
  """
  def init(config) do
    json =
      cond do
        File.exists?("priv/gcp-config.json") ->
          File.read!("priv/gcp-config.json")

        File.exists?("/var/run/secrets/goth/gcp-config.json") ->
          File.read!("/var/run/secrets/goth/gcp-config.json")

        System.get_env("GCP_CONFIG_PATH") != nil ->
          System.get_env("GCP_CONFIG_PATH") |> File.read!()
      end

    {:ok, Keyword.put(config, :json, json)}
  end
end
