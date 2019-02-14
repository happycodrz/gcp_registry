defmodule GcpRegistry.Table do
  @moduledoc """
  support module to render ASCII table from different responses
  """

  def inspect({:ok, %GcpRegistry.Response{manifest: manifest}}) do
    manifest
    |> Map.values()
    |> GcpRegistry.Sorter.sort(:timeCreatedMs)
    |> manifests()
  end

  # @spec manifest([:]) GcpRegistry.Manifest
  def manifests(items) do
    rows =
      items
      |> Enum.map(fn x ->
        [x.sha, x.tag |> Enum.join(", "), x.timeCreatedMs]
      end)

    TableRex.quick_render(
      rows,
      ["Sha", "Tag", "Created"]
    )
    |> elem(1)
    |> IO.puts()
  end
end
