# FROM archlinux/archlinux:base-devel

# Last version without the problem:
FROM archlinux/archlinux:base-devel-20250209.0.306672

# First version introducing the problem:
# FROM archlinux/archlinux:base-devel-20250210.0.306967 

RUN echo -e "source /etc/profile" >> ~/.bashrc

# Install required packages for building libadwaita and all dependencies
RUN pacman -Sy --noconfirm git curl zip unzip tar cmake ninja python-distutils-extra libx11 libxext \
    libxrender libxrandr libxi libxcursor libxdamage libxinerama libdrm xorg-server-xvfb fontconfig

ARG PACKAGE=binutils
ARG VERSION=2.44
RUN cd /tmp \
    && curl -L -O https://ftp.gnu.org/gnu/${PACKAGE}/${PACKAGE}-${VERSION}.tar.xz \
    && tar -xf ${PACKAGE}-${VERSION}.tar.xz \
    && cd ${PACKAGE}-${VERSION} \
    && ./configure \
    --with-lib-path=/usr/lib:/usr/local/lib \
    --enable-cet \
    --enable-colored-disassembly \
    --enable-default-execstack=no \
    --enable-deterministic-archives \
    --enable-gold \
    --enable-install-libiberty \
    --enable-jansson \
    --enable-ld=default \
    --enable-new-dtags \
    --enable-pgo-build=lto \
    --enable-plugins \
    --enable-relro \
    --enable-shared \
    --enable-targets=x86_64-pep,bpf-unknown-none \
    --enable-threads \
    --disable-gdb \
    --disable-gdbserver \
    --disable-libdecnumber \
    --disable-readline \
    --disable-sim \
    --disable-werror \
    --with-pic \
    --with-system-zlib \
    && make -O tooldir=/usr \
    && make install \
    && rm -rf /tmp/binutils-gdb

# Remove all binutils binaries installed by the package manager
RUN cd /usr/bin \
    && rm addr2line ar as c++filt dwp elfedit gp-* gprof* ld.bfd ld.gold nm objcopy objdump ranlib readelf size strip strings

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
