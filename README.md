# Deploying the 12urenloop stack

# Requirements

## Inventory

Gather the following:

- [ ] 1 Flight case with router/switch:
    - See the  [Network documentation](TODO LINK)

- [ ] 2 clients:
    - Dell thin clients
    - `snowball` & `meeseeks` from Zeus
    - These will be wiped!

- [ ] 8 ronnys:
    - Also known as stations
    - Raspberry Pi 4's
    - These will be wiped!

- [ ] 1 laptop with `uv` installed

Make everything is labelled:
    - [ ] `client1-2`
    - [ ] `ronny01-08`
    - [ ] What ports on the switch are to be used for the `telnet` (tel-network).

## Static DHCP leases

The router should automatically assign IP addresses based on MAC address via DHCP as follows:

| Host    | IP            | MAC               |
|---------|---------------|-------------------|
| client1 | 172.12.50.21  | 90:8D:6E:8C:8A:01 |
| client2 | 172.12.50.22  | 90:8D:6E:8C:8A:9B |
| ronny01 | 172.12.50.101 | DC:A6:32:49:97:00 |
| ronny02 | 172.12.50.102 | DC:A6:32:49:9A:90 |
| ronny03 | 172.12.50.103 | E4:5F:01:4A:42:DE |
| ronny04 | 172.12.50.104 | DC:A6:32:49:62:B4 |
| ronny05 | 172.12.50.105 | DC:A6:32:49:65:33 |
| ronny06 | 172.12.50.106 | E4:5F:01:4A:40:E2 |
| ronny07 | 172.12.50.107 | DC:A6:32:49:97:E7 |
| ronny08 | 172.12.50.108 | DC:A6:32:49:98:CD |

> If you replace any hardware, make sure to update the MAC in the router config, this table and the [Network documentation](TODO LINK)

## Preparing devices for ansible

### Clients

Wipe and install Debian on the clients as described in [Preparing a client for ansible](TODO LINK):
    - [ ] `client1`
    - [ ] `client2`

### Ronnys

Flash the ronnys and set a password as described in [Preparing a ronny for ansible](TODO LINK):
    - [ ] `ronny01`
    - [ ] `ronny02`
    - [ ] `ronny03`
    - [ ] `ronny04`
    - [ ] `ronny05`
    - [ ] `ronny06`
    - [ ] `ronny07`
    - [ ] `ronny08`

### Laptop

- [ ] Clone the [ansible-config](https://github.com/12urenloop/ansible-config/) repository on the laptop and follow the install instructions for dependencies in the `README.md`.

## Prepare

```sh
command -v uv || (curl -LsSf https://astral.sh/uv/install.sh | sh)
uv venv --python=python3.14
source .venv/bin/activate
uv pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

As long as you use `source .venv/bin/activate` first, you should now have the `ansible` command.

## What can you find here?

`playbook-dns.yml`

Installs **coredns** onto client2. (see `hosts.ini`)
This can be used for service discovery in for example prometheus.

`playbook.yml`

On all servers

- Configure the local dns server -> coredns + the router.

On the clients

- Setup correct ssh access for the crew
- Install prometheus postgres exporter
    - client1 -> primary telraam database
    - client2 -> replicated telraam database

## How to use it

Run a playbook. This will use the hosts specified in `hosts.ini`.

    ansible-playbook playbook.yml


Running an ad-hoc command on a group of devices:

```sh
ansible -kK -i hosts.yml station -a 'sudo /sbin/shutdown -t 0'
```
