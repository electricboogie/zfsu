zfstx & zfsret
==============

**zfstx** maintains a mirror of a ZFS pool over the network. It is based on [ZFS transfer](https://github.com/jvsalo/zfs_transfer). Rather than pushing snapshots off to a remote host,it **pulls** remote snapshots into a local filesystem. That way, all the mirroring logic can be centralized on the backup-host.

**zfsret** is a simple script to apply local retention (destroy snapshots) of a filesystem and its snapshots.

zfstx
-----

**Usage**
```
$ zfstx
Usage: zfstx [OPTIONS] <remote-host>:<remote-fs> <local-fs>
Pull ZFS snapshots from a remote host into the local zpool.

Arguments:
  <remote-host>            - Remote host, e.g. myhost
  <remote-fs>              - Filesystem on remote host, e.g. tank/home
  <local-fs>               - Filesystem on local host, e.g. backuppool/myhost/home

Options:
  -k, --keep <count>       - preserved history length
  -b, --mbuffer <bufsz>    - mbuffer buffer size, default 4G
  -p, --port <port>        - custom SSH port, default 22
  -P, --no-pigz            - disable pigz
  -n, --dry-run            - Don't apply changes, just print (experimental)
```

**Examples**
```
$ zfstx platop:tank/home/pheckel tank/backups/platop/home/pheckel
  # Pull all (missing) snapshots from host "platop" into the local pool "tank"
  # and don't apply any retention.
  
$ zfstx --keep 5 platop:tank/home/pheckel/vms tank/backups/platop/home/pheckel/vms
  # Pull all (missing) snapshots from host "platop" into the local pool "tank"
  # and only keep the 5 latest snapshots locally.
``
