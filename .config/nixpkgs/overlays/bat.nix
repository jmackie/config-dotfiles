let
    # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
    bat =
        { stdenv, fetchFromGitHub, rustPlatform, zlib, cmake }:
        rustPlatform.buildRustPackage rec {
            name = "bat-${version}";
            version = "0.4.1";

            src = fetchFromGitHub {
                owner = "sharkdp";
                repo = "bat";
                rev = "195d5e0e16ba76ee3cc554d8fb30382dd22fcbf8";
                sha256 = "0fiif6b8g2hdb05s028dbcpav6ax0qap2hbsr9p2bld4z7j7321m";
            };

            cargoSha256 = "0w0y3sfrpk8sn9rls90kjqrqr62pd690ripdfbvb5ipkzizp429l";

            nativeBuildInputs = [ zlib cmake ];
        };
in
self: super:
{
    bat = super.callPackage bat { };
}
