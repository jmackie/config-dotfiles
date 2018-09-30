let
    srmio =
        { stdenv, fetchgit, autoreconfHook }:

        stdenv.mkDerivation rec {
            name = "srmio-${version}";
            version = "${stdenv.lib.strings.substring 0 7 rev}";
            rev = "e84852ae9fd3f823c32128aa84be33036678bcd8";

            src = fetchgit {
                inherit rev;
                url = "https://github.com/rclasen/srmio.git";
                sha256 = "1ka0x4ahnk5182i71np8qx6j244x3s2s11ab6b67jfg48bcfldkv";
            };
            nativeBuildInputs = [ autoreconfHook ];
            preConfigure = "sh genautomake.sh";
        };
in
self: super:
{
    srmio = super.callPackage srmio { };
}
