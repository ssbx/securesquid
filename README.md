Secure SQUID
============

Ce dépot contient des utilitaires qui permettent de construire/activer squid avec toutes les fonctionnalités de sécurités disponnibles (actuellement, seulement ClamAv).

## Create a local clamav build

```sh
$ ./generate.sh clamav_local
$ ~/opt/clamav/bin/freshclam
$ ~/opt/clamav/bin/clamscan -r ~
```

## Create a local squid build

```sh
$ ./generate.sh squid_local
```
