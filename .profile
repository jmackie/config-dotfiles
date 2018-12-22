if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        # shellcheck source=/dev/null
        . "$HOME/.bashrc"
    fi
fi

CABAL_HOME="$HOME/.cabal"
export CABAL_HOME

if [ ! -d "$CABAL_HOME" ]; then
    echo -n "\$CABAL_HOME not found, creating..."
    mkdir -p "$CABAL_HOME"
    echo 'DONE'
fi

CARGO_HOME="$HOME/.cargo"
export CARGO_HOME

if [ ! -d "$CARGO_HOME" ]; then
    echo -n "\$CARGO_HOME not found, creating..."
    mkdir -p "$CARGO_HOME"
    echo 'DONE'
fi

RUSTUP_HOME="$HOME/.rustup"
export RUSTUP_HOME

if [ ! -d "$RUSTUP_HOME" ]; then
    echo -n "\$RUSTUP_HOME not found, creating..."
    mkdir -p "$RUSTUP_HOME"
    echo 'DONE'
fi

GOPATH="$HOME/.gopath"
export GOPATH
if [ ! -d "$GOPATH" ]; then
    echo -n "\$GOPATH not found, creating..."
    mkdir -p "$GOPATH"
    echo 'DONE'
fi

PATH="$CABAL_HOME/bin:$CARGO_HOME/bin:$GOPATH/bin:$PATH"

GH="https://github.com/jmackie"
export GH

COWPATH="$(realpath "$(dirname "$(readlink "$(command -v cowsay)")")/../share/cows")"
export COWPATH
