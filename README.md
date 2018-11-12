# golang-tools
[![Build Status](https://travis-ci.org/ibrt/golang-tools.svg?branch=master)](https://travis-ci.org/ibrt/golang-tools)

### govm

```
usage: govm [<flags>] <command> [<args> ...]

Install & manage multiple versions of the Go toolchain on macOS.

Flags:

  -h,  --help  Print a summary help and exit.

Commands:

  install <version>
    Downloads the given Go toolchain version and installs it at '~/.govm/go<version>'.
    Use the 'activate' command to activate an installed version.
    e.g. 'govm install 1.10'

  uninstall <version>
    Removes the given Go toolchain version from '~/.govm/go<version>'.
    e.g. 'govm uninstall 1.10'

  activate <version>
    Prints out the variable exports needed to use the given Go toolchain version.
    Copy them to your '~/.bash_profile' (or equivalent) to activate this version as default.
    Run 'eval $(govm activate <version>)' to activate this version for the current session. 

  list
    Prints a list of installed Go toolchain versions.
    e.g. 'govm list'
```

### gobin

```
usage: gobin [<flags>] <command> [<args> ...]

Install & update Go-based binaries on macOS.

Flags:

  -h,  --help  Print a summary help and exit.

Commands:

  install <package>
    Creates a temporary GOPATH, runs 'go get' with the given package, and copies any compiled binaries to '~/.gobin'.
    e.g. 'gobin install golang.org/x/lint/golint/...'
    Please make sure '~/.gobin' is added to your $PATH.

  update <binary>
    Finds the package through which the given binary was installed and runs 'gobin install <package>'.
    e.g. 'gobin update golint'

  uninstall <binary>
    Removes the given binary from '~/.gobin'.
    e.g. 'gobin uninstall golint'

  list
    Prints a list of installed binaries and their corresponding source packages.
    e.g. 'gobin list'
```
