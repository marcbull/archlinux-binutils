# FROM archlinux/archlinux:base-devel

# Last version without the problem:
# FROM archlinux/archlinux:base-devel-20250209.0.306672

# First version introducing the problem:
FROM archlinux/archlinux:base-devel-20250210.0.306967 

RUN echo -e "source /etc/profile" >> ~/.bashrc

# Install required packages for building libadwaita and all dependencies
RUN pacman -Sy --noconfirm git curl zip unzip tar cmake ninja python-distutils-extra libx11 libxext \
    libxrender libxrandr libxi libxcursor libxdamage libxinerama libdrm xorg-server-xvfb fontconfig

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
