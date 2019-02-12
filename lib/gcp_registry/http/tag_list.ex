defmodule GcpRegistry.HTTP.TagList do
  alias GcpRegistry.HTTP
  alias GcpRegistry.Params
  alias GcpRegistry.Cache

  def get(url) do
    api_url = Params.from_url(url) |> Params.to_tags_list_url()

    with {:ok, res} <- HTTP.get(api_url),
         {:ok, structs} <- GcpRegistry.Response.make(res) do
      {:ok, structs}
    end
  end

  def get_cached(url) do
    Cache.get(url, fn ->
      get(url)
    end)
  end
end
