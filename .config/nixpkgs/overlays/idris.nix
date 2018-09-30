self: super:
{
    idris = with super.idrisPackages; with-packages [
        base
        prelude
        contrib
    ];
}
