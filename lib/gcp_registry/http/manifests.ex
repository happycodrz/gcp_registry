defmodule GcpRegistry.HTTP.Manifests do
  alias GcpRegistry.HTTP
  alias GcpRegistry.Params
  alias GcpRegistry.Cache

  def get(url) do
    api_url = Params.from_url(url) |> Params.to_manifests_url()

    with {:ok, res} <-
           HTTP.get(api_url, [{"Accept", "application/vnd.docker.distribution.manifest.v2+json"}]) do
      {:ok, res}
    end
  end

  def get_cached(url) do
    Cache.get(url, fn ->
      get(url)
    end)
  end
end
