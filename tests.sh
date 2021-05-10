#!/usr/bin/env bash

set -e

# setup
sudo rm -rf "/usr/bin/go"
sudo rm -rf "/usr/local/bin/go"
rm -rf "$HOME/.govm"
rm -rf "$HOME/.gobin"
which go && (echo 'error: go is already installed'; exit 1)
which golint && (echo 'error: golint is already installed'; exit 1)
export PATH="$HOME/.gobin:$PATH"

echo "> install go"
"./tools/govm" install 1.16.4
[[ -d "$HOME/.govm/go1.16.4" ]] || (echo 'error: go is not installed'; exit 1)

echo "> activate go"
eval "$("./tools/govm" activate 1.16.4)"
[[ "$(which go)" == "$HOME/.govm/go1.16.4/bin/go" ]] || (echo 'error: go is not activated'; exit 1)
go version | grep "go1.16.4"

echo "> install another go"
"./tools/govm" install 1.16.3
[[ -d "$HOME/.govm/go1.16.3" ]] || (echo 'error: go is not installed'; exit 1)

echo "> list go versions"
LIST="$("./tools/govm" list)"
[[ "$LIST" == "go1.16.3\n1.16.4\n" ]] || (echo 'error: unexpected list'; exit 1)

# install golint
echo "> install golint"
"./tools/gobin" install "golang.org/x/lint/golint"
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not installed'; exit 1)
[[ "$(which golint)" == "$HOME/.gobin/golint" ]] || (echo 'error: golint is not found at the expected path'; exit 1)
golint

# update golint
echo "> update golint"
"./tools/gobin" update golint
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not installed'; exit 1)
[[ "$(which golint)" == "$HOME/.gobin/golint" ]] || (echo 'error: golint is not found at the expected path'; exit 1)
golint

# uninstall golint
echo "> uninstall golint"
"./tools/gobin" uninstall golint
[[ ! -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not uninstalled'; exit 1)

# uninstall go
echo "> uninstall go 1.16.4"
"./tools/govm" uninstall 1.16.4
[[ ! -d "$HOME/.govm/go1.16.4" ]] || (echo 'error: go is not uninstalled'; exit 1)
