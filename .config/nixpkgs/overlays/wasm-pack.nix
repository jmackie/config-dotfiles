let
    # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
    wasm-pack =
        { stdenv, fetchFromGitHub, rustPlatform, pkgconfig, openssl }:

        rustPlatform.buildRustPackage rec {
            name = "wasm-pack-${version}";
            version = "0.4.2";

            src = fetchFromGitHub {
                owner = "rustwasm";
                repo = "wasm-pack";
                rev = "5304a496250eb5d0c3c7e4ae666cf67d028b804a";
                sha256 = "127s39iiwhxs4ylaahpk53nl6a1kjcrqqqm1zw4q3q1zajlb5vb8";
            };

            cargoSha256 = "0my5f5jmcm05w0gbjgf8m4xzsdfq1rkndi0ix0c9f1mwxfvfakyq";
            nativeBuildInputs = [ pkgconfig openssl ];
        };
in
self: super:
{
    wasm-pack = super.callPackage wasm-pack { };
}
