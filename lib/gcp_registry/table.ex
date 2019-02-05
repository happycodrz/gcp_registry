defmodule GcpRegistry.Table do
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
