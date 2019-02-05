defmodule GcpRegistry.HTTP do
  alias GcpRegistry.Creds

  @doc """
  algorithm:
    1. start on top
    2. visit every child until "child" => [] (empty)
    3. manifest
      - images with tags and timestamps
  """
  def get(url, headers \\ []) do
    with {:ok, res} <- GcpRegistry.HTTP.request(:get, url, headers) do
      # res |> GcpRegistry.Response.make!()
      res
    end
  end

  def put(url, body, headers \\ []) do
    with {:ok, res} <- GcpRegistry.HTTP.request(:put, url, headers) do
      # res |> GcpRegistry.Response.make!()
      res
    end
  end

  def request(:get, url, headers) do
    HTTPoison.get(url, authheaders(headers))
    |> process()
  end

  def request(:put, url, body, headers) do
    HTTPoison.put(url, body, authheaders(headers))
    |> process()
  end

  def authheaders(headers \\ []) do
    token = Creds.get_token()
    [{"Authorization", "#{token.type} #{token.token}"}] ++ headers
  end

  def process({:ok, %{body: body, headers: headers}}) do
    b =
      if is_json(headers) do
        body |> Jason.decode!()
      else
        body
      end

    {:ok, b}
  end

  def content_type(headers) do
    headers |> Enum.find(fn {k, _v} -> k == "Content-Type" end) |> elem(1)
  end

  def is_json(headers) do
    content_type(headers) == "application/json" or
    content_type(headers) == "application/vnd.docker.distribution.manifest.v2+json" or
    content_type(headers) == "application/vnd.docker.distribution.manifest.v1+prettyjws"
  end
end
