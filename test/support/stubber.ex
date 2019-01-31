defmodule Stubber do
  @moduledoc """
  configures mocks for
    - Goth (connection_mock)
  """
  import Mimic

  defmodule GcpRegistryMock do
    def get("a") do
    end
    def get("a/b") do
    end
  end

  def setup_stubs() do
    GcpRegistry.Client
    |> stub(:get, &GcpRegistryMock.get/1)
  end
end
