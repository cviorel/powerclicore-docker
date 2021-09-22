# Manage VMs using PowerCLI

## Download the container from the docker hub

```sh
docker pull vmware/powerclicore
```

## Open an interactive Terminal and run

```sh
docker run --rm -it vmware/powerclicore /bin/bash
```

## Create snapshot

```sh
source .env

docker run --rm \
--entrypoint="/usr/bin/pwsh" \
-e VI_SERVER=${VI_SERVER} \
-e VI_USERNAME=${VI_USERNAME} \
-e VI_PASSWORD=${VI_PASSWORD} \
-v ${PWD}/vm_list:/tmp/vm_list \
-v ${PWD}/scripts:/tmp/scripts \
vmware/powerclicore \
/tmp/scripts/take-snapshot.ps1
```

## Revert to last snapshot

```sh
source .env

docker run --rm \
--entrypoint="/usr/bin/pwsh" \
-e VI_SERVER=${VI_SERVER} \
-e VI_USERNAME=${VI_USERNAME} \
-e VI_PASSWORD=${VI_PASSWORD} \
-v ${PWD}/vm_list:/tmp/vm_list \
-v ${PWD}/scripts:/tmp/scripts \
vmware/powerclicore \
/tmp/scripts/revert-lastsnapshot.ps1
```

## Remove snapshots

```sh
source .env

docker run --rm \
--entrypoint="/usr/bin/pwsh" \
-e VI_SERVER=${VI_SERVER} \
-e VI_USERNAME=${VI_USERNAME} \
-e VI_PASSWORD=${VI_PASSWORD} \
-v ${PWD}/vm_list:/tmp/vm_list \
-v ${PWD}/scripts:/tmp/scripts \
vmware/powerclicore \
/tmp/scripts/remove-snapshot.ps1
```
