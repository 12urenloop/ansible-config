# ansible config

Add the file `.vault-password`. Ask the password to the developers. You often find them on the [mattermost instance](https://mattermost.zeus.gent/) of ZeusWPI.

## Prepare

Make sure to install `ansible` and check that you have the commands `ansible-playbook` and `ansible-galaxy` in your `PATH`.

Install some external roles that we use

    ansible-galaxy install -r requirements.yml -p roles


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
