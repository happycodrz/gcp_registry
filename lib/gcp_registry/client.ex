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
  alias GcpRegistry.HTTP.TagList

  @doc """
  List existing images
  $ gcloud container images list --repository=gcr.io/myproject
  """
  def list_images(url) do
    TagList.list_images(url)
  end

  @doc """
  $ gcloud container images list-tags --help
  """
  def list_tags(url) do
    TagList.list_tags(url)
  end

  @doc """
   $ gcloud container images add-tag gcr.io/myproject/myimage:mytag1
          gcr.io/myproject/myimage:mytag2

    Promote a tag to latest
        $ gcloud container images add-tag gcr.io/myproject/myimage:mytag1
          gcr.io/myproject/myimage:latest
  """
  def add_tag(_src_img, _tag) do
    # TODO
  end

  @doc """
  $ gcloud topic filters
  """
  def filtering() do
  end
end
