defmodule GcpRegistry.HTTP.Manifests do
  alias GcpRegistry.{HTTP, Params, Cache, ManifestsResponse}
  @headers [{"Accept", "application/vnd.docker.distribution.manifest.v2+json"}]

  def get(url) do
    api_url = Params.from_url(url) |> Params.to_manifests_url()

    with {:ok, res} <- HTTP.get(api_url, @headers) do
      {:ok, ManifestsResponse.make!(res)}
    end
  end

  def get_cached(url) do
    Cache.get("manifests+" <> url, fn ->
      get(url)
    end)
  end
end
