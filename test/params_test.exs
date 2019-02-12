defmodule GcpRegistry.URLParserTest do
  use ExUnit.Case
  alias GcpRegistry.Params

  describe "from_url" do
    test "parses https://eu.gcr.io/project1/company1/repo1/branch1" do
      url = "https://eu.gcr.io/project1/company1/repo1/branch1"
      assert Params.from_url(url) |> Map.get(:hostname) == "eu.gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "project1"
      assert Params.from_url(url) |> Map.get(:image) == "company1/repo1/branch1"
    end

    test "parses https://gcr.io/project1/company1/repo1/branch1" do
      url = "https://gcr.io/project1/company1/repo1/branch1"
      assert Params.from_url(url) |> Map.get(:hostname) == "gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "project1"
      assert Params.from_url(url) |> Map.get(:image) == "company1/repo1/branch1"
    end

    test "parses https://asia.gcr.io/project1/company1/repo1/branch1" do
      url = "https://asia.gcr.io/project1/company1/repo1/branch1"
      assert Params.from_url(url) |> Map.get(:hostname) == "asia.gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "project1"
      assert Params.from_url(url) |> Map.get(:image) == "company1/repo1/branch1"
    end

    test "parses https://gcr.io/project1/company1" do
      url = "https://gcr.io/project1/company1"
      assert Params.from_url(url) |> Map.get(:hostname) == "gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "project1"
      assert Params.from_url(url) |> Map.get(:image) == "company1"
    end

    test "parses https://gcr.io/project1" do
      url = "https://gcr.io/project1"
      assert Params.from_url(url) |> Map.get(:hostname) == "gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "project1"
      assert Params.from_url(url) |> Map.get(:image) == ""
    end

    test "parses gcr.io/myproject/myimage:mytag1" do
      url = "gcr.io/myproject/myimage:mytag1"

      assert Params.from_url(url) |> Map.get(:hostname) == "gcr.io"
      assert Params.from_url(url) |> Map.get(:projectid) == "myproject"
      assert Params.from_url(url) |> Map.get(:image) == "myimage"
      assert Params.from_url(url) |> Map.get(:tag) == "mytag1"
    end
  end

  describe "to_tags_list_url" do
    test "works with existing image" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: "company1/repo1"
      }

      url = "https://gcr.io/v2/proj1/company1/repo1/tags/list"
      assert Params.to_tags_list_url(params) == url
    end

    test "works with empty image" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: ""
      }

      url = "https://gcr.io/v2/proj1/tags/list"
      assert Params.to_tags_list_url(params) == url
    end
  end

  describe "to_manifests_url" do
    test "works with existing image and tag" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: "company1/repo1",
        tag: "sometag"
      }

      url = "https://gcr.io/v2/proj1/company1/repo1/manifests/sometag"
      assert Params.to_manifests_url(params) == url
    end

    test "fails with empty image" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: ""
      }

      assert_raise FunctionClauseError, fn ->
        Params.to_manifests_url(params)
      end
    end

    test "fails with empty tag" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: "someimage",
        tag: ""
      }

      assert_raise FunctionClauseError, fn ->
        Params.to_manifests_url(params)
      end
    end
  end
end
