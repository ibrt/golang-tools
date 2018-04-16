#!/usr/bin/env bash

set -e

[[ ! -z "$TRAVIS_BUILD_DIR" ]] || (echo 'error: $TRAVIS_BUILD_DIR unset'; exit 1)
rm -rf "$HOME/.govm"

echo "> install go 1.10.1"
"$TRAVIS_BUILD_DIR/govm" install 1.10.1
[[ -d "$HOME/.govm/go1.10.1" ]] || (echo 'error: 1.10.1 installation not found'; exit 1)
echo "> activate go 1.10.1"
eval $("$TRAVIS_BUILD_DIR/govm" activate 1.10.1)
[[ "$(which go)" == "$HOME/.govm/go1.10.1/bin/go" ]] || (echo 'error: 1.10.1 not activated'; exit 1)
echo "> uninstall go 1.10.1"
"$TRAVIS_BUILD_DIR/govm" uninstall 1.10.1
[[ ! -d "$HOME/.govm/go1.10.1" ]] || (echo 'error: 1.10.1 installation found'; exit 1)
