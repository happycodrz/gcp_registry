defmodule GcpRegistry.Client do
  # {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/pubsub")
  # HTTPoison.get(url, [{"Authorization", "#{token.type} #{token.token}"}])

  @doc """
  algorithm:
    1. start on top
    2. visit every child until "child" => [] (empty)
    3. manifest
      - images with tags and timestamps
  """
  def get(url) do
    token = GcpRegistry.Creds.get_token()
    HTTPoison.get(url, [{"Authorization", "#{token.type} #{token.token}"}]) |> process()
  end

  def process({:ok, %{body: body, headers: headers}}) do
    if is_json(headers) do
      body |> Jason.decode!()
    else
      body
    end
  end

  def content_type(headers) do
    headers |> Enum.find(fn {k, _v} -> k == "Content-Type" end) |> elem(1)
  end

  def is_json(headers) do
    content_type(headers) == "application/json"
  end
end
