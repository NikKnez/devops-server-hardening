# Testing Guide

## Local VM Testing

### 1. Create Test VM
```bash
# Using VirtualBox or VMware
# Install Ubuntu 22.04 LTS
# Minimum specs: 1GB RAM, 10GB disk
```

### 2. Setup SSH Access
```bash
# On VM
sudo apt update
sudo apt install -y openssh-server

# Get VM IP
ip addr show

# From host machine
ssh-copy-id user@VM_IP
```

### 3. Clone and Test
```bash
# On VM
git clone https://github.com/NikKnez/devops-server-hardening.git
cd devops-server-hardening

# Run hardening
sudo ./scripts/harden-server.sh

# Validate
sudo ./tests/validate-hardening.sh
```

### 4. Verify SSH Access
```bash
# From host, open NEW terminal (don't close existing one!)
ssh user@VM_IP

# If locked out, use VM console to fix
```

## CI/CD Testing

GitHub Actions runs validation on every PR (see `.github/workflows/test.yml`)
