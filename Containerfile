FROM docker.io/alpine:latest AS builder

WORKDIR /chr-router
RUN apk add --no-cache unzip wget grep \
    && export ROUTEROS_VERSION=$(wget -qO- https://mikrotik.com/download | grep -oP '<th>7\.[0-9]+\.[0-9]+ Stable</th>' | head -1 | grep -oP '7\.[0-9]+\.[0-9]+') \
    && wget https://cdn.mikrotik.com/routeros/${ROUTEROS_VERSION}/chr-${ROUTEROS_VERSION}.img.zip \
    && unzip chr-${ROUTEROS_VERSION}.img.zip \
    && mv chr-${ROUTEROS_VERSION}.img routeros.img

FROM quay.io/almalinuxorg/almalinux-bootc:10

COPY usr/ /usr/
COPY etc/ /etc/
COPY --from=builder /chr-router/routeros.img /usr/share/chr-router/

RUN dnf -y install \
    libvirt-daemon-common \
    libvirt-daemon-driver-network \
    libvirt-daemon-driver-nodedev \
    libvirt-daemon-driver-qemu \
    libvirt-daemon-driver-storage-core \
    libvirt-client \
    python3-libvirt \
    python3-dbus \
    qemu-kvm-core \
    qemu-img \
    && ln -s ../libvirt-guests.service /usr/lib/systemd/system/multi-user.target.wants/libvirt-guests.service \
    && dnf clean all \
    && bootc container lint
