defmodule GcpRegistry.HTTP.TagListTest do
  use ExUnit.Case
  import Mimic
  alias GcpRegistry.HTTP.TagList
  setup :set_mimic_global

  def to_time(s) do
    DateTime.from_iso8601(s) |> elem(1)
  end

  describe ":list_tags" do
    setup do
      Stubber.setup_stubs()
      :ok
    end

    test "works for repos" do
      res = "eu.gcr.io/project1/company1/repo1" |> TagList.list_tags()
      assert res == []
    end

    test "works for repo branches" do
      res = "eu.gcr.io/project1/company1/repo1/branch1" |> TagList.list_tags()

      assert res == [
               %GcpRegistry.Manifest{
                 imageSizeBytes: 15_171_842,
                 layerId: "",
                 mediaType: "application/vnd.docker.distribution.manifest.v2+json",
                 sha: "0918630c0b66",
                 tag: [],
                 timeCreatedMs: to_time("2017-12-27 12:52:21.470Z"),
                 timeUploadedMs: to_time("2017-12-27 12:52:29.387Z")
               },
               %GcpRegistry.Manifest{
                 imageSizeBytes: 15_171_490,
                 layerId: "",
                 mediaType: "application/vnd.docker.distribution.manifest.v2+json",
                 sha: "067f4d40f8d3",
                 tag: ["67e67747be891b7ea1b0440b35a41296342c91fd", "latest"],
                 timeCreatedMs: to_time("2017-12-22 14:39:15.598Z"),
                 timeUploadedMs: to_time("2017-12-22 14:39:24.775Z")
               }
             ]
    end
  end

  describe ":list_images" do
    setup do
      Stubber.setup_stubs()
      :ok
    end

    test "works for repos" do
      res = "eu.gcr.io/project1/company1/repo1" |> TagList.list_images()
      assert res == ["branch1", "branch2"]
    end

    test "works for repo branches" do
      res = "eu.gcr.io/project1/company1/repo1/branch1" |> TagList.list_images()
      assert res == []
    end
  end

  describe ":find_tag" do
    setup do
      Stubber.setup_stubs()
      :ok
    end

    test "works for repos" do
      res = "eu.gcr.io/project1/company1/repo1" |> TagList.find_tag("latest")
      assert res == nil
    end

    test "works for branches" do
      res =
        "eu.gcr.io/project1/company1/repo1/branch1" |> TagList.find_tag("latest") |> Map.get(:tag)

      assert res == ["67e67747be891b7ea1b0440b35a41296342c91fd", "latest"]
    end
  end

  describe ":get" do
    setup do
      Stubber.setup_stubs()
      :ok
    end

    test "works for repos" do
      {:ok, res} = "eu.gcr.io/project1/company1/repo1" |> TagList.get()

      assert res == %GcpRegistry.Response{
               child: ["branch1", "branch2"],
               manifest: %{},
               name: "project1/company1/repo1",
               tags: []
             }
    end

    test "works for repo branches" do
      {:ok, res} = "eu.gcr.io/project1/company1/repo1/branch1" |> TagList.get()

      assert res == %GcpRegistry.Response{
               child: [],
               manifest: %{
                 "sha256:067f4d40f8d32b023879a1bfcec67fdf870daee4f307a9f079b3059fd2e53c0e" =>
                   %GcpRegistry.Manifest{
                     imageSizeBytes: 15_171_490,
                     layerId: "",
                     mediaType: "application/vnd.docker.distribution.manifest.v2+json",
                     tag: ["67e67747be891b7ea1b0440b35a41296342c91fd", "latest"],
                     timeCreatedMs: to_time("2017-12-22 14:39:15.598Z"),
                     timeUploadedMs: to_time("2017-12-22 14:39:24.775Z")
                   },
                 "sha256:0918630c0b6662e639a4344637f882be14ac53d355859e2e440ae676e0fa8288" =>
                   %GcpRegistry.Manifest{
                     imageSizeBytes: 15_171_842,
                     layerId: "",
                     mediaType: "application/vnd.docker.distribution.manifest.v2+json",
                     tag: [],
                     timeCreatedMs: to_time("2017-12-27 12:52:21.470Z"),
                     timeUploadedMs: to_time("2017-12-27 12:52:29.387Z")
                   }
               },
               name: "project1/company1/repo1/branch1",
               tags: [
                 "67e67747be891b7ea1b0440b35a41296342c91fd",
                 "f1a5e3104f44abc0ef72e415262ff635d74baac6",
                 "latest"
               ]
             }
    end
  end
end
