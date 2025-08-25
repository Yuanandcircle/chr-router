# chr-router

`chr-router` is an automated deployment framework for MikroTik RouterOS CHR on x86 platforms, leveraging libvirt and systemd for robust virtualization management. Designed for bare-metal routers and appliances, it delivers a fully unattended installation workflow.

## Features

1. Fully automated provisioning of RouterOS CHR virtual machines, with dynamic network bridge creation for all ethernet interfaces.
2. Utilizes bootc container technology to provide an immutable, reliable host operating system.
3. Automatically powers off the RouterOS CHR during the host's initial shutdown after installation, ensuring proper device-mode transitions (required for enabling features such as containers in RouterOS).
4. Implements automatic time synchronization between host and VM to maintain system clock accuracy and prevent drift.

## Warning

The generated anaconda-iso performs unattended installation and will irreversibly erase all local and network-attached storage devices. **Use with extreme caution.**
