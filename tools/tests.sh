#!/usr/bin/env bash

set -e

# setup
[[ ! -z "$TRAVIS_BUILD_DIR" ]] || (echo 'error: $TRAVIS_BUILD_DIR unset'; exit 1)
sudo rm -rf "/usr/local/bin/go"
rm -rf "$HOME/.govm"
rm -rf "$HOME/.gobin"
which go && (echo 'error: go is already installed'; exit 1)
which golint && (echo 'error: golint is already installed'; exit 1)
export PATH="$HOME/.gobin:$PATH"

echo "> install go"
"$TRAVIS_BUILD_DIR/tools/govm" install 1.10.1
[[ -d "$HOME/.govm/go1.10.1" ]] || (echo 'error: go is not installed'; exit 1)

# activate go
echo "> activate go"
eval $("$TRAVIS_BUILD_DIR/tools/govm" activate 1.10.1)
[[ "$(which go)" == "$HOME/.govm/go1.10.1/bin/go" ]] || (echo 'error: go is not activated'; exit 1)
go version | grep "go1.10.1"

# install golint
echo "> install golint"
"$TRAVIS_BUILD_DIR/tools/gobin" install "golang.org/x/lint/golint"
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not installed'; exit 1)
[[ "$(which golint)" == "$HOME/.gobin/golint" ]] || (echo 'error: golint is not found at the expected path'; exit 1)
golint

# update golint
echo "> update golint"
"$TRAVIS_BUILD_DIR/tools/gobin" update golint
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not installed'; exit 1)
[[ "$(which golint)" == "$HOME/.gobin/golint" ]] || (echo 'error: golint is not found at the expected path'; exit 1)
golint

# uninstall golint
echo "> uninstall golint"
"$TRAVIS_BUILD_DIR/tools/gobin" uninstall golint
[[ ! -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not uninstalled'; exit 1)

# uninstall go
echo "> uninstall go 1.10.1"
"$TRAVIS_BUILD_DIR/tools/govm" uninstall 1.10.1
[[ ! -d "$HOME/.govm/go1.10.1" ]] || (echo 'error: go is not uninstalled'; exit 1)
