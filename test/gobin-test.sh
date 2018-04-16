#!/usr/bin/env bash

set -e

[[ ! -z "$TRAVIS_BUILD_DIR" ]] || (echo 'error: $TRAVIS_BUILD_DIR unset'; exit 1)
rm -rf "$HOME/.gobin"

echo "> install golint"
"$TRAVIS_BUILD_DIR/gobin" install "golang.org/x/lint/golint"
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint not installed'; exit 1)
echo "> update golint"
"$TRAVIS_BUILD_DIR/gobin" update golint
[[ -f "$HOME/.gobin/golint" ]] || (echo 'error: golint not installed'; exit 1)
echo "> uninstall golint"
"$TRAVIS_BUILD_DIR/gobin" uninstall golint
[[ ! -f "$HOME/.gobin/golint" ]] || (echo 'error: golint not installed'; exit 1)