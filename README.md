# containerfile-lab0

## Gurobi grbts Build & Run
- sudo podman build --tag rlinfati/containerfile-lab0:grbts-999 github.com/rlinfati/containerfile-lab0 --file Dockerfile.grbts
- sudo podman run --rm --interactive --tty --name grbts --mac-address 01:02:03:04:05:06 --hostname server.domain.tld --pid=host --volume OPTgurobi:/opt/gurobi --publish 41954:41954 --replace rlinfati/containerfile-lab0:grbts-999 grbgetkey --path /opt/gurobi/ 00000000-0000-0000-0000-000000000000
- sudo podman create   --interactive --tty --name grbts --mac-address 01:02:03:04:05:06 --hostname server.domain.tld --pid=host --volume OPTgurobi:/opt/gurobi --publish 41954:41954 --replace rlinfati/containerfile-lab0:grbts-999
- sudo podman start grbts
- sudo podman exec -it grbts curl 1.1.1.1

## StrongSwan eap-tls Build & Run
- sudo podman build --tag rlinfati/containerfile-lab0:ikev2-tls-999 github.com/rlinfati/containerfile-lab0 --file Dockerfile.ikev2-tls
- sudo podman run --rm --interactive --tty --name ikev2-tls --replace --volume IKEv2-letsencrypt:/etc/letsencrypt --volume IKEv2-swanctl:/etc/strongswan/swanctl --network host --entrypoint '' rlinfati/containerfile-lab0:ikev2-tls-999 /opt/certbot/bin/certbot certonly --verbose --standalone --domain server.domain.tld --register-unsafely-without-email --agree-tos
- sudo podman run --rm --interactive --tty --name ikev2-tls --replace --volume IKEv2-letsencrypt:/etc/letsencrypt --volume IKEv2-swanctl:/etc/strongswan/swanctl --network host --entrypoint bash rlinfati/containerfile-lab0:ikev2-tls-999
- cp /etc/letsencrypt/live/server.domain.tld/cert.pem /etc/strongswan/swanctl/x509/le-ikev2-srv.crt && cp /etc/letsencrypt/live/server.domain.tld/privkey.pem /etc/strongswan/swanctl/private/le-ikev2-srv.key
- vi /etc/strongswan/swanctl/conf.d/ikev2-server.domain.tld.conf
- sudo podman create --interactive --tty --name ikev2-tls --replace --volume IKEv2-letsencrypt:/etc/letsencrypt --volume IKEv2-swanctl:/etc/strongswan/swanctl --network host --privileged rlinfati/containerfile-lab0:ikev2-tls-999
- sudo podman start ikev2-tls
- sudo podman exec -it ikev2-tls curl 1.1.1.1

## Samba AD-DC Build & Run
- sudo podman build --tag rlinfati/containerfile-lab0:samba-999 github.com/rlinfati/containerfile-lab0 --file Dockerfile.samba

## Slurm Build & Run
- sudo podman build --tag rlinfati/containerfile-lab0:slurm-control-999 github.com/rlinfati/containerfile-lab0 --file Dockerfile.slurm --target slurm-control
- sudo podman build --tag rlinfati/containerfile-lab0:slurm-runner-999  github.com/rlinfati/containerfile-lab0 --file Dockerfile.slurm --target slurm-runner
- sudo podman run --rm -dit --name slurm-control0 --replace --hostname slurm-control0 rlinfati/containerfile-lab0:slurm-control-999
- sudo podman run --rm -dit --name slurm-runner01 --replace rlinfati/containerfile-lab0:slurm-runner-999
- sudo podman run --rm -dit --name slurm-runner02 --replace rlinfati/containerfile-lab0:slurm-runner-999
- sudo podman run --rm -dit --name slurm-runner03 --replace rlinfati/containerfile-lab0:slurm-runner-999
- sudo podman run --rm -dit --name slurm-runner04 --replace rlinfati/containerfile-lab0:slurm-runner-999
- sudo podman exec -it slurm-control0 bash
- sudo podman container stop slurm-control0 slurm-runner01 slurm-runner02 slurm-runner03 slurm-runner04
