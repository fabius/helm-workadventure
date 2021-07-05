# Helm Chart to deploy Workadventure

These are a couple of Helm Charts to deploy

- [WorkAdventure](https://github.com/thecodingmachine/workadventure)
- [Jitsi Meet](https://github.com/jitsi/jitsi-meet).
- [cert-manager](https://github.com/jetstack/cert-manager)

## Prerequisites

### CLI tools

- `kubectl` v1.21.x
- `helm` v3.6.x
- `make` (only if you want to use the provided [Makefile](Makefile))

### K8s

Get a K8S cluster. This setup has been tested on
[DigitalOceans K8s](https://www.digitalocean.com/products/kubernetes/) offering.
(v1.21.x)

Have a domain at your disposal. This is necessary for TLS termination provided
by cert-manager.

These charts work with both `nginx` and `traefik`. `traefik` is the default
though. If you do not have a running `traefik` LB deployment running, deploy one
yourself:

```sh
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm upgrade --install traefik traefik/traefik -f traefikvalues.yaml
```

## Deploy

Customize [values.yaml](values.yaml) to your liking. At the very least, change
`domain` and `tls.acmeMail`. Obviously, you would want to change everything
related to secrets for a production setup.

Then run

```sh
make up
```

Or copy paste the commands from the [Makefile](Makefile) if that's your jam.

## Acknowledgements

This repo has been made possible by these fellows:

- [gmoirod](https://github.com/gmoirod): Provided a working
  [WorkAdventure chart](https://github.com/gmoirod/helm-workadventure)
- [rsoika](https://github.com/rsoika): I
  [kustomized](https://github.com/jitsi-contrib/jitsi-kubernetes) my way into a
  helm chart
