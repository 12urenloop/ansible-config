# ansible config

Add the file `.vault-password`. Ask the password to the developers. You often find them on the [mattermost instance](https://mattermost.zeus.gent/) of ZeusWPI.

## Prepare

Install any version of `uv`.

In this repository, run:

```sh
uv venv --python=python3.14 --seed
source .venv/bin/activate
pip install -r requirements.txt
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
