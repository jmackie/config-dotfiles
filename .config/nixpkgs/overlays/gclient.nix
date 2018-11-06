self: super:
{
    gclient = super.stdenv.mkDerivation {
        name = "gclient";
        src = super.fetchgit {
            url = "https://chromium.googlesource.com/chromium/tools/depot_tools.git";
            rev = "cb629a482b3d3c13e46a66031ba4c0cc3679d200";
            sha256 = "1kss7fqrw51k30z0pk1iiix867naj2w011irnrkvaa878y7rk7ls";
            fetchSubmodules = false;
        };
        buildPhase = null;
        installPhase = ''
            mkdir -p $out/bin
            cp ./gclient.py $out/bin/gclient
            touch $out/bin/metrics.cfg

            # Python dependencies
            cp ./detect_host_arch.py $out/bin/detect_host_arch.py
            cp ./download_from_google_storage.py $out/bin/download_from_google_storage.py
            cp ./fix_encoding.py $out/bin/fix_encoding.py
            cp ./gclient_eval.py $out/bin/gclient_eval.py
            cp ./gclient_scm.py $out/bin/gclient_scm.py
            cp ./gclient_utils.py $out/bin/gclient_utils.py
            cp ./git_cache.py $out/bin/git_cache.py
            cp ./metrics.py $out/bin/metrics.py
            cp ./metrics_utils.py $out/bin/metrics_utils.py
            cp ./scm.py $out/bin/scm.py
            cp ./setup_color.py $out/bin/setup_color.py
            cp ./subcommand.py $out/bin/subcommand.py
            cp ./subprocess2.py $out/bin/subprocess2.py

            cp -r ./third_party $out/bin/third_party
        '';
        buildInputs = [
            super.python27
        ];
    };
}
