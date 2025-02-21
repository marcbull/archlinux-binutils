# Project to demonstrate a problem in the Arch Linux binutils package

## Description of the problem

The Arch Linux package `binutils 2.44-1` introduces a problem when building the `libadwaita` library in `vcpkg`.

The last working docker image was `archlinux/archlinux:base-devel-20250209.0.306672`, and the first docker image introducing this problem was `archlinux/archlinux:base-devel-20250210.0.306967`.

## Steps to reproduce

```bash
git clone https://github.com/marcbull/archlinux-binutils.git
cd archlinux-binutils
./run.sh && vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo
```

To build a libadwaita with a downgraded binutils, you can use the following command:

```bash
./run.sh downgrade && vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo
```
