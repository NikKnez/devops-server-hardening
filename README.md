# Server Hardening Scripts

Automated scripts for securing Linux servers according to CIS benchmarks and best practices.

## Purpose

Collection of bash scripts to harden Ubuntu/Debian servers for production use. These scripts automate security configurations that would otherwise be done manually.

## Features

- **SSH Hardening**: Disable root login, enforce key-based auth
- **Firewall Setup**: Configure UFW with sensible defaults
- **Automatic Updates**: Enable unattended security updates
- **User Management**: Create limited-privilege users
- **Audit Logging**: Configure system audit daemon
- **Fail2Ban Setup**: Protect against brute-force attacks

## Quick Start
```bash
# Clone repository
git clone https://github.com/NikKnez/devops-server-hardening.git
cd devops-server-hardening

# Run full hardening (requires sudo)
sudo ./scripts/harden-server.sh

# Or run individual scripts
sudo ./scripts/harden-ssh.sh
sudo ./scripts/setup-firewall.sh
```

## Structure
```
scripts/
├── harden-server.sh      # Main orchestration script
├── harden-ssh.sh         # SSH security configuration
├── setup-firewall.sh     # UFW firewall rules
├── setup-fail2ban.sh     # Fail2ban installation & config
├── enable-auto-updates.sh # Automatic security updates
└── create-sudo-user.sh   # User creation with sudo access

docs/
├── SECURITY.md           # Security considerations
├── TESTING.md            # How to test in VM
└── ROLLBACK.md           # How to undo changes

tests/
└── validate-hardening.sh # Verification script
```

## Requirements

- Ubuntu 22.04 LTS or Debian 11/12
- Root or sudo access
- Minimum 1GB RAM
- Internet connection for package installation

## Usage

### Full Hardening
```bash
sudo ./scripts/harden-server.sh
```

This runs all hardening scripts in order:
1. SSH hardening
2. Firewall setup
3. Fail2ban installation
4. Automatic updates
5. Audit configuration

### Individual Scripts

Each script can be run independently:
```bash
# Harden SSH only
sudo ./scripts/harden-ssh.sh

# Setup firewall only
sudo ./scripts/setup-firewall.sh
```

### Validation

After hardening, verify configuration:
```bash
sudo ./tests/validate-hardening.sh
```

## Warning

**Test in a VM first!** These scripts make significant security changes that may lock you out if misconfigured.

## Testing

See [TESTING.md](docs/TESTING.md) for detailed testing instructions.

## Security

See [SECURITY.md](docs/SECURITY.md) for security considerations and threat model.

## License

MIT License - See LICENSE file

## Contributing

Pull requests welcome! Please read CONTRIBUTING.md first.

## Author

**Nikola Knezevic**
- AWS Certified Cloud Practitioner
- GitHub: [@NikKnez](https://github.com/NikKnez)
- LinkedIn: [Nikola Knezevic](https://linkedin.com/in/nikola-knezevic-devops)

## References

- [CIS Ubuntu Linux Benchmark](https://www.cisecurity.org/benchmark/ubuntu_linux)
- [SSH Hardening Guide](https://www.ssh.com/academy/ssh/server)
- [UFW Documentation](https://help.ubuntu.com/community/UFW)
