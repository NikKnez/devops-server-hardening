#!/bin/bash
# Enable Automatic Security Updates

set -euo pipefail

log() {
    echo "[AUTO-UPDATES] $1"
}

# Install unattended-upgrades
apt-get update
apt-get install -y unattended-upgrades apt-listchanges

# Configure automatic updates
cat > /etc/apt/apt.conf.d/50unattended-upgrades << 'AUTOEOF'
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}-security";
};
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
Unattended-Upgrade::MinimalSteps "true";
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
AUTOEOF

# Enable automatic updates
cat > /etc/apt/apt.conf.d/20auto-upgrades << 'ENABLEEOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
ENABLEEOF

log "✓ Automatic security updates enabled"
