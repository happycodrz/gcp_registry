defmodule GcpRegistry.Params do
  @moduledoc """
  represent arguments to for a request to gcr.io registry
  """

  alias __MODULE__

  defstruct hostname: nil,
            projectid: nil,
            image: nil

  @type t :: %GcpRegistry.Params{
          hostname: String.t(),
          projectid: String.t(),
          image: String.t()
        }

  @doc """
  https://cloud.google.com/container-registry/docs/pushing-and-pulling?hl=en
    The four options are:
      gcr.io hosts the images in the United States, but the location may change in the future
      us.gcr.io hosts the image in the United States, in a separate storage bucket from images hosted by gcr.io
      eu.gcr.io hosts the images in the European Union
      asia.gcr.io hosts the images in Asia

  Combine the hostname, your Google Cloud Platform Console project ID, and image name:
    [HOSTNAME]/[PROJECT-ID]/[IMAGE]
  """
  @spec from_url(url :: binary) :: GcpRegistry.Params.t()
  def from_url(url) do
    [prefix, proj_image] =
      url
      |> String.replace("https://", "")
      |> String.split("gcr.io/")

    [project_id, image] =
      cond do
        String.contains?(proj_image, "/") -> proj_image |> String.split("/", parts: 2)
        true -> [proj_image, ""]
      end

    %Params{
      hostname: "#{prefix}gcr.io",
      projectid: project_id,
      image: image
    }
  end
end
