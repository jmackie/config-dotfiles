self: super:
{
    # HACK:
    flutter = super.stdenv.mkDerivation {
        name = "flutter-0.8.2beta";
        src = super.fetchurl {
            url = "https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_v0.8.2-beta.tar.xz";
            sha256 = "19cpkbnmhn0pd1kwmxfzmkx2cbr5daymzicnjaw6zyj26adyq0f2";
        };

        # https://github.com/NixOS/nixpkgs/issues/36759#issuecomment-413226172
        buildPhase = null;
        installPhase = ''
            mkdir $out
            cp -avr . $out
            find $out/bin/ -executable -exec patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) {} \;
        '';
    };
}
