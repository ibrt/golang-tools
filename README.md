# golang-tools
[![Build Status](https://travis-ci.org/ibrt/golang-tools.svg?branch=master)](https://travis-ci.org/ibrt/golang-tools)

Useful tools for the savvy Go programmer.

### Installation

#### Mac OS

```
$ brew tap ibrt/tap
$ brew install golang-tools
```

Add `~/.gobin` to the default `$PATH`:

```
$ echo 'export PATH="$HOME/.gobin:$PATH"' >> ~/.bash_profile
$ echo 'export PATH="$HOME/.gobin:$PATH"' >> ~/.zprofile
```

#### Linux

Simply download the shell scripts from under `./tools` to somewhere in your `$PATH` (e.g. `/usr/local/bin`) and make them executable.

### Uninstallation

#### Mac OS

```
$ brew uninstall golang-tools
$ rm -rf "$HOME/.govm" "$HOME/.gobin"
```

#### Linux

```
$ rm -rf /usr/local/bin/govm /usr/local/bin/gobin "$HOME/.govm" "$HOME/.gobin"
```

### Tools

#### gobin

This tool makes it easy to install & update Go-based binaries such as `golint`, `go-bindata`, etc. When the `gobin install <package>` command is invoked, a temporary GOPATH is created and `go get <package>` is executed. Any binary executable found under `$GOPATH/bin` is then copied to `~/.gobin`. Finally, the temporary GOPATH is removed.

The tool keeps track of the relationships between Go packages and binary executables. Updates and uninstalls can be requested using the binary name (e.g. `gobin update golint`) instead of the corresponding package.

```
usage: gobin [<flags>] <command> [<args> ...]

Install & update Go-based binaries.

Flags:

  -h,  --help  Print a summary help and exit.

Commands:

  install <package>
    Creates a temporary GOPATH, runs 'go get <package>', copies binaries from '$GOPATH/bin' to '~/.gobin'.
    e.g. 'gobin install golang.org/x/lint/golint/...'

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

#### govm

This tool is a version manager for the Go toolchain. Installed Go toolchains are placed under `~/.govm/go<version>`. The `activate` command makes it easy to export the `$PATH` and `$GOROOT` environment variables needed to activate a specific version. To set a default version, add `eval $(govm activate <version>)` to your `~/.bash_profile`, `~/.zprofile` or similar.

```
usage: govm [<flags>] <command> [<args> ...]

Install & manage multiple versions of the Go toolchain.

Flags:

  -h,  --help  Print a summary help and exit.

Commands:

  install <version>
    Downloads the given Go toolchain version and installs it at '~/.govm/go<version>'.
    Use the 'activate' command to activate an installed version.
    e.g. 'govm install 1.16'

  uninstall <version>
    Removes the given Go toolchain version from '~/.govm/go<version>'.
    e.g. 'govm uninstall 1.16'

  activate <version>
    Prints out the variable exports needed to use the given Go toolchain version.
    Run 'eval $(govm activate <version>)' to activate this version for the current session.
    Run 'echo 'eval $(govm activate <version>)' >> ~/.bash_profile' to set a default version.

  list
    Prints a list of installed Go toolchain versions.
    e.g. 'govm list'
```
