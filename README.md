# Project to demonstrate a problem in the Arch Linux binutils package

## Description of the problem

The `binutils 2.44` package introduces a problem when building the `libadwaita` library in `vcpkg`. The library and demo binary will be built successfully; however, it will malfunction when run. The issue resides within the library itself, as all binaries utilizing the library encounter the same failure when executed.

The problem was observed in ArchLinux and could be traced back to the following docker image, which had several updated packages. Preliminary analysis suggests a potential association with ld.

The last working docker image was `archlinux/archlinux:base-devel-20250209.0.306672`, and the first docker image with this problem was `archlinux/archlinux:base-devel-20250210.0.306967`.

If you build `binutils 2.44` in ArchLinux and install it in `/usr/local`, and if you then remove all existing binutils binaries provided by the package, it will fail to build a functional `libadwaita`. However, if you remove all binaries, except `ld`, it will build libadwaita as expected.

## Steps to reproduce

```bash
git clone https://github.com/marcbull/archlinux-binutils.git
cd archlinux-binutils
./run.sh && vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo
```

To build a libadwaita with ld of version 2.43, you can use the following command:

```bash
./run.sh ld-2.43 && vcpkg_installed/x64-linux-dynamic/bin/adwaita-1-demo
```
