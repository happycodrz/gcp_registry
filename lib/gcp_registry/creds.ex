defmodule GcpRegistry.Creds do
  require Logger

  def get_token do
    with {:ok, token} <- current_token() do
      # refreshing token in Goth is not working properly, so we do it ourselves instead
      if DateTime.compare(DateTime.from_unix!(token.expires), DateTime.utc_now()) == :lt do
        fresh_token()
      else
        token
      end
    end
  end

  @doc """
  this looks expensive, but is not. Goth is caching this request internally
  """
  def current_token do
    Goth.Token.for_scope("https://www.googleapis.com/auth/cloud-platform")
  end

  def fresh_token do
    with {:ok, token} <- current_token() do
      Logger.debug("Goth: getting fresh token for: #{inspect(token)}")

      with {:ok, newtoken} <- Goth.Token.refresh!(token) do
        newtoken
      end
    end
  end
end
