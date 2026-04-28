# ansible-config

**See https://12urenloop.github.io/docs.12urenloop/DEPLOYING**

## Prepare

Make sure `uv` is installed:

```console
command -v uv || (curl -LsSf https://astral.sh/uv/install.sh | sh)
```

Create a `.venv`:

```console
uv venv --python=python3.14
source .venv/bin/activate
```

Install dependencies:

```console
uv pip install -r requirements.txt
ansible-galaxy install -r requirements.yml
```

As long as you use `source .venv/bin/activate` first, you should now have the `ansible` command.

## How to use it

Run a playbook. This will use the hosts specified in `hosts.ini`.

```sh
ansible-playbook -kK playbook-01-common-init.yml
```

Running an ad-hoc command on a group of devices:

```sh
ansible -kK -i hosts.yml station -a 'sudo /sbin/shutdown -t 0'
```

## TODO

- Have telraam take db config through env vars
- Generate ssh keys on client 1 & 2, place them in each other and the pi's `authorized_keys`
- Manual count needs to have `host: [client 2 ip]` set in frontend vite config
