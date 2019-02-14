defmodule GcpRegistry.HTTP.TagList do
  alias GcpRegistry.{HTTP, Params, Cache, Manifest, Sorter, Response}
  alias __MODULE__

  def list_images(url) do
    with {:ok, structs} <- TagList.get_cached(url) do
      structs |> Map.get(:child)
    end
  end

  def list_tags(url) do
    with {:ok, structs} <- TagList.get_cached(url) do
      structs
      |> Map.get(:manifest)
      |> Enum.map(fn {key, value} ->
        value
        |> Map.put(:sha, key)
        |> Manifest.make!()
      end)
      |> GcpRegistry.Sorter.sort(:timeCreatedMs)
    end
  end

  def get(url) do
    api_url = Params.from_url(url) |> Params.to_tags_list_url()

    with {:ok, res} <- HTTP.get(api_url),
         {:ok, structs} <- GcpRegistry.Response.make(res) do
      {:ok, structs}
    end
  end

  def get_cached(url) do
    Cache.get("tags+" <> url, fn ->
      get(url)
    end)
  end
end
