defmodule GcpRegistry.HTTP.ManifestsTest do
  use ExUnit.Case
  import Mimic
  alias GcpRegistry.HTTP.Manifests
  setup :set_mimic_global

  def to_time(s) do
    DateTime.from_iso8601(s) |> elem(1)
  end

  describe ":get" do
    setup do
      Stubber.setup_stubs()
      :ok
    end

    test "works for repos with tags" do
      {:ok, res} =
        "eu.gcr.io/project1/company1/repo1/branch1:sometag" |> GcpRegistry.HTTP.Manifests.get()

      assert res == %{
               "config" => %{
                 "digest" =>
                   "sha256:04d115964a3698721491a9e0b772055e96721bad58d66f35e837e675a36ff6b9",
                 "mediaType" => "application/vnd.docker.container.image.v1+json",
                 "size" => 5613
               },
               "layers" => [
                 %{
                   "digest" =>
                     "sha256:2fdfe1cd78c20d05774f0919be19bc1a3e4729bce219968e4188e7e0f1af679d",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 2_064_911
                 },
                 %{
                   "digest" =>
                     "sha256:ee6e861b6feaaf32c291c5d66d28af63b9eca2d0be625b536ef942cfe94ff5e4",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 94
                 },
                 %{
                   "digest" =>
                     "sha256:f102745085b12b68e8604136a9e6ec46332003ea928dbf72054e6a33b6f959cb",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 4_097_668
                 },
                 %{
                   "digest" =>
                     "sha256:107f012aa16c1d28927df32c218a21568154ff68b5bf40438168ebb532371f25",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 5_309_157
                 },
                 %{
                   "digest" =>
                     "sha256:e702654a291508a3d31d7de0f7bf32dae18557eb5d868cb72109cc8246578100",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 476
                 },
                 %{
                   "digest" =>
                     "sha256:94a20384890f06f25e5ec2a92a8b6d249d09705f43a9ce624251d20006ecde3b",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 657
                 },
                 %{
                   "digest" =>
                     "sha256:0a9b1796ee82d78d3db03248f8a45b548597ec5c47002599afeae0cece8a5210",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 485
                 },
                 %{
                   "digest" =>
                     "sha256:1246d2329a397090ff06395f494a522f941e7cbfedc5351cad2908fb590b2007",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 3_672_572
                 },
                 %{
                   "digest" =>
                     "sha256:2de5a61a33843ef6e34f748eb30df8e1b3466a989c09709555ea1d06e32cd142",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 134
                 },
                 %{
                   "digest" =>
                     "sha256:0cf4fd9d8255612559a1869e49f98e899fe85ced4633ea62dd7f6ee3068227d9",
                   "mediaType" => "application/vnd.docker.image.rootfs.diff.tar.gzip",
                   "size" => 4168
                 }
               ],
               "mediaType" => "application/vnd.docker.distribution.manifest.v2+json",
               "schemaVersion" => 2
             }
    end
  end
end
