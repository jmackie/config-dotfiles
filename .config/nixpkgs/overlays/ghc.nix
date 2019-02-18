self: super:
{
    ghcWithPackages = super.haskell.packages.ghc863.ghcWithPackages (pkgs: with pkgs; [
        cabal-install
        stack
        hpack
    ]);

    # Older stack projects need this attribute to be present
    # in order to build with Nix.
    #haskell.compiler.ghc821 = super.haskell.compiler.ghc821Binary;
}
