defmodule GcpRegistry.Client do
  @moduledoc """
  a high level client for gcp.io registries
  mimics `gcloud container images` commands
     add-tag - Adds tags to existing image.
     delete - Delete existing images.
     describe - Lists information about the specified image.
     list - List existing images.
     list-tags - List tags and digests for the specified image.
     untag - Remove existing image tags.
  """
  alias GcpRegistry.Params
  alias GcpRegistry.{Manifest}

  @doc """
  List existing images
  $ gcloud container images list --repository=gcr.io/myproject
  """
  def list(url) do
    with {:ok, structs} <- GcpRegistry.HTTP.TagList.get(url) do
      structs |> Map.get(:child)
    end
  end

  @doc """
  $ gcloud container images list-tags --help
  """
  def list_tags(url) do
    with {:ok, structs} <- GcpRegistry.HTTP.TagList.get(url) do
      structs
      |> Map.get(:manifest)
      |> Enum.map(fn {key, value} ->
        value
        |> Map.put(:sha, key)
        |> Manifest.make!()
      end)
      |> GcpRegistry.Sorter.sort(:timeCreatedMs)
    end
  end

  @doc """
   $ gcloud container images add-tag gcr.io/myproject/myimage:mytag1
          gcr.io/myproject/myimage:mytag2

    Promote a tag to latest
        $ gcloud container images add-tag gcr.io/myproject/myimage:mytag1
          gcr.io/myproject/myimage:latest
  """
  def add_tag(src_img, tag) do
    params = Params.from_url(src_img) |> IO.inspect()
  end

  @doc """
  $ gcloud topic filters
  """
  def filtering() do
  end
end
