defmodule GcpRegistry.UnixTime do
  @behaviour Construct.Type
  def cast(v) when is_binary(v), do: v |> String.to_integer() |> DateTime.from_unix(:millisecond)
  def cast(_), do: :error
end

defmodule GcpRegistry.Manifest do
  use Construct do
    field :imageSizeBytes, :integer
    field :layerId, :string
    field :mediaType, :string
    field :timeCreatedMs, GcpRegistry.UnixTime
    field :timeUploadedMs, GcpRegistry.UnixTime
    field :tag, {:array, :string}
  end
end

defmodule GcpRegistry.Response do
  use Construct do
    field(:child, {:array, :string})
    field(:tags, {:array, :string})
    field(:name, :string)
    field :manifest, {:map, GcpRegistry.Manifest}
  end
end
