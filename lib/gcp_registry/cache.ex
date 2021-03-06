defmodule GcpRegistry.Cache do
  use GenServer
  @name __MODULE__
  @tblname :gcp_registry_cache

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def init(state) do
    :ets.new(@tblname, [:set, :public, :named_table])
    {:ok, state}
  end

  def get(key) do
    case :ets.lookup(@tblname, key) do
      [] -> nil
      [{_key, value}] -> value
    end
  end

  def get(key, fun) do
    case get(key) do
      nil ->
        v = fun.()
        put(key, v)
        v

      v ->
        v
    end
  end

  def put(key, value) do
    :ets.insert(@tblname, {key, value})
  end

  def delete(key) do
    :ets.delete(@tblname, key)
  end

  def list() do
    :ets.tab2list(@tblname)
  end

  def reset() do
    :ets.delete_all_objects(@tblname)
  end
end
