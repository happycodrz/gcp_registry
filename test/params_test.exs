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
      assert Params.from_url(url) |> Map.get(:image) == "myimage:mytag1"
    end
  end

  describe "to_api_url" do
    test "works with existing image" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: "company1/repo1"
      }

      url = "https://gcr.io/v2/proj1/company1/repo1/tags/list"
      assert Params.to_api_url(params) == url
    end

    test "works with empty image" do
      params = %Params{
        hostname: "gcr.io",
        projectid: "proj1",
        image: ""
      }

      url = "https://gcr.io/v2/proj1/tags/list"
      assert Params.to_api_url(params) == url
    end
  end
end
