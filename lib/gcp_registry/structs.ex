defmodule GcpRegistry.UnixTime do
  @behaviour Construct.Type
  def cast(v) when is_binary(v), do: v |> String.to_integer() |> DateTime.from_unix(:millisecond)
  def cast(v = %DateTime{}), do: {:ok, v}
  def cast(_), do: :error
end

defmodule GcpRegistry.ContainerSha do
  @behaviour Construct.Type
  # "sha256:d148cf9cd373f4de1958091a05ddef23d0cac743fcc7eb680973c527f161100e"
  def cast(v) when is_binary(v),
    do: {:ok, v |> String.split(":") |> Enum.at(1) |> String.slice(0, 12)}

  def cast(_), do: :error
end

defmodule GcpRegistry.Manifest do
  use Construct do
    field(:sha, GcpRegistry.ContainerSha, default: "")
    field(:imageSizeBytes, :integer)
    field(:layerId, :string)
    field(:mediaType, :string)
    field(:timeCreatedMs, GcpRegistry.UnixTime)
    field(:timeUploadedMs, GcpRegistry.UnixTime)
    field(:tag, {:array, :string})
  end
end

defmodule GcpRegistry.Response do
  use Construct do
    field(:child, {:array, :string})
    field(:tags, {:array, :string})
    field(:name, :string)
    field(:manifest, {:map, GcpRegistry.Manifest})
  end
end

defmodule GcpRegistry.DockerLayer do
  use Construct do
    field(:digest, :string)
    field(:mediaType, :string)
    field(:size, :integer)
  end
end

defmodule GcpRegistry.ManifestsResponse do
  use Construct do
    field(:config, GcpRegistry.DockerLayer)
    field(:layers, {:array, GcpRegistry.DockerLayer})
    field(:mediaType, :string)
    field(:schemaVersion, :integer)
  end
end
