defmodule Stubber do
  @moduledoc """
  configures mocks for
    - Goth (connection_mock)
  """
  import Mimic

  defmodule ClientMock do
    def request("https://eu.gcr.io/v2/project1/company1/repo1/tags/list") do
      {:ok,
       %{
         "child" => ["branch1", "branch2"],
         "manifest" => %{},
         "name" => "project1/company1/repo1",
         "tags" => []
       }}
    end

    def request("https://eu.gcr.io/v2/project1/company1/repo1/branch1/tags/list") do
      {:ok,
       %{
         "child" => [],
         "manifest" => %{
           "sha256:067f4d40f8d32b023879a1bfcec67fdf870daee4f307a9f079b3059fd2e53c0e" => %{
             "imageSizeBytes" => "15171490",
             "layerId" => "",
             "mediaType" => "application/vnd.docker.distribution.manifest.v2+json",
             "tag" => ["67e67747be891b7ea1b0440b35a41296342c91fd", "latest"],
             "timeCreatedMs" => "1513953555598",
             "timeUploadedMs" => "1513953564775"
           },
           "sha256:0918630c0b6662e639a4344637f882be14ac53d355859e2e440ae676e0fa8288" => %{
             "imageSizeBytes" => "15171842",
             "layerId" => "",
             "mediaType" => "application/vnd.docker.distribution.manifest.v2+json",
             "tag" => [],
             "timeCreatedMs" => "1514379141470",
             "timeUploadedMs" => "1514379149387"
           }
         },
         "name" => "project1/company1/repo1/branch1",
         "tags" => [
           "67e67747be891b7ea1b0440b35a41296342c91fd",
           "f1a5e3104f44abc0ef72e415262ff635d74baac6",
           "latest"
         ]
       }}
    end
  end

  defmodule GcpRegistry.CredsMock do
    def get_token() do
      %Goth.Token{
        account: :default,
        expires: 1_548_980_287,
        scope: "https://www.googleapis.com/auth/cloud-platform",
        sub: nil,
        token:
          "ya29.c.ElqjBmkxIL1YntIXseO6KNhxifShZrqPIGzrjk_R46PibMSNgnKHckK33PwQj02mmxGaBEaF79ddaef1HOAKz-bugeQm2bRK9mB1lrVlmx0xZ-j5O7zy975dc0s",
        type: "Bearer"
      }
    end
  end

  def setup_stubs() do
    :"Elixir.GcpRegistry.Client"
    |> stub(:request, &ClientMock.request/1)

    :"Elixir.GcpRegistry.Creds"
    |> stub(:get_token, &GcpRegistry.CredsMock.get_token/0)
  end
end
