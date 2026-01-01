#!/bin/bash
# Validate Server Hardening

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

pass() {
    echo -e "${GREEN}✓${NC} $1"
}

fail() {
    echo -e "${RED}✗${NC} $1"
}

echo "========================================="
echo "Server Hardening Validation"
echo "========================================="

# Check SSH configuration
if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config; then
    pass "SSH: Root login disabled"
else
    fail "SSH: Root login NOT disabled"
fi

if grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    pass "SSH: Password authentication disabled"
else
    fail "SSH: Password authentication NOT disabled"
fi

# Check firewall
if ufw status | grep -q "Status: active"; then
    pass "Firewall: UFW is active"
else
    fail "Firewall: UFW is NOT active"
fi

# Check fail2ban
if systemctl is-active --quiet fail2ban; then
    pass "Fail2ban: Service is running"
else
    fail "Fail2ban: Service is NOT running"
fi

# Check automatic updates
if [[ -f /etc/apt/apt.conf.d/20auto-upgrades ]]; then
    pass "Auto-updates: Configured"
else
    fail "Auto-updates: NOT configured"
fi

echo "========================================="
echo "Validation Complete"
echo "========================================="
