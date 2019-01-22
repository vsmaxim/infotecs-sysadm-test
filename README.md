# infotecs-sysadm-test

## Installation

```
git clone https://github.com/vsmaxim/infotecs-sysadm-test && cp ./infotecs-sysadm-test/{backup-sql,ipscan,pskiller} /usr/local/bin/
```

For scripts you need nmap installed in your system, in ArchLinux it's done via: 
```
sudo pacman -S nmap
```
For other distros, you may better look into distro-specific documentation.

## Notes

### PostgreSQL backup script

Example of usage: `backup-sql ./path-to-config.config`

### IP Scanner script

Example of usage: `ipscaner 192.168.0.0/30`

Regarding to how nmap works, it'll ask you to prompt sudo password, or you can just call it explicitly with sudo using: `sudo ipscanner 192.168.0.0/30`.


### PSKiller script

Example of usage: `pskiller chrome ./passwords.txt localhost 192.168.1.101 192.168.1.102`
