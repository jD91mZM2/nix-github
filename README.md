# GitHub Action for Nix Flakes

A simple GitHub Action that installs Nix with the experimental Flakes feature.

I made this mostly for learning purposes. You might want to use [Install
Nix](https://github.com/marketplace/actions/install-nix) instead.

## Example

``` yaml
on: [ push, pull_request ]

jobs:
  ci:
    runs-on: ubuntu-latest
    name: Testing flakes
    steps:
    - uses: actions/checkout@v2
    - uses: actions/cache@v2
      with:
        path: ~/.nix
        key: always
    - uses: jD91mZM2/nix-github@master
    - run: nix build .
    - run: nix run .
```

## How it works

The simplest usage comes down to adding this step:

``` yaml
- uses: jD91mZM2/nix-github@master
```

But that's slow - it reinstalls Nix each time. There's a trick you can do,
however, to speed it up! Cache!

nix-github will use bind mounts to set up the actual nix store at ~/.nix,
meaning it's an accessible directory for GitHub Actions to extract. All you
need to do is use `actions/cache`, like this:

``` yaml
- uses: actions/cache@v2
  with:
    path: ~/.nix
    key: always
- uses: jD91mZM2/nix-github@master
```
