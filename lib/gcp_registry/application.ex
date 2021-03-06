defmodule GcpRegistry.Application do
  require Logger
  @moduledoc false

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: GcpRegistry.Supervisor]
    children = [{GcpRegistry.Cache, []}]
    Supervisor.start_link(children, opts)
  end
end
