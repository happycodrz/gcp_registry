defmodule GcpRegistry.URLParserTest do
  use ExUnit.Case
  alias GcpRegistry.Params

  describe "parse" do
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
  end
end
