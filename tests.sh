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
"./tools/govm" list
[[ "$("./tools/govm" list | tr '\r\n' ' ')" == "1.16.3 1.16.4 " ]] || (echo 'error: unexpected list'; exit 1)

echo "> install golint"
"./tools/gobin" install "golang.org/x/lint/golint"
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint is not installed'; exit 1)
[[ "$(which golint)" == "$HOME/.gobin/golint" ]] || (echo 'error: golint is not found at the expected path'; exit 1)
golint

echo "> install gotest"
"./tools/gobin" install "github.com/rakyll/gotest"
[[ -f "$HOME/.gobin/gotest" ]] || (echo 'error: gotest is not installed'; exit 1)
[[ "$(which gotest)" == "$HOME/.gobin/gotest" ]] || (echo 'error: gotest is not found at the expected path'; exit 1)
golint

echo "> list bins"
[[ "$("./tools/gobin" list | tr '\n' ' ')" == "golint: golang.org/x/lint/golint gotest: github.com/rakyll/gotest " ]] || (echo 'error: unexpected list'; exit 1)

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
