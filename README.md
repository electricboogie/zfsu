ZFS Utilities (zfsu)
====================

**zfsu** is a collection of ZFS utilities. It consists of the following tools:

- **zfsu tx** (aka **zfstx**) maintains a mirror of a ZFS pool over the network. It is based on [ZFS transfer](https://github.com/jvsalo/zfs_transfer). Rather than pushing snapshots off to a remote host,it **pulls** remote snapshots into a local filesystem. That way, all the mirroring logic can be centralized on the backup-host.

- **zfsu ret** (aka **zfsret**) is a simple script to apply local retention (destroy snapshots) of a filesystem and its snapshots.

- **zfsu res** (aka **zfsres**) is script to resilver a slow mirror, e.g. a HDD disk if mirrored with a SSH.

zfsu tx (zfstx)
--------------

**Usage**
```bash
$ zfsu tx
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
```bash
$ zfstx platop:tank/home/pheckel tank/backups/platop/home/pheckel
  # Pull all (missing) snapshots from host "platop" into the local pool "tank"
  # and don't apply any retention.
  
$ zfstx --keep 5 platop:tank/home/pheckel/vms tank/backups/platop/home/pheckel/vms
  # Pull all (missing) snapshots from host "platop" into the local pool "tank"
  # and only keep the 5 latest snapshots locally.
```

zfsu ret (zfsret)
-----------------

**Usage**
```bash
$ zfsu ret
Usage: zfsret [OPTIONS] <local-fs> <keep>
Destroy local ZFS snapshots for a specific filesystem.

Arguments:
  <local-fs>               - Filesystem on local host, e.g. backuppool/myhost/home
  <keep>                   - Number of snapshots to keep

Options:
  -n, --dry-run            - Don't apply changes, just print
```

**Examples**
```bash
$ zfsu ret tank/home/pheckel 10
  # Destroy all but 10 snapshots of filesystem tank/home/pheckel
  # This is not recursive (no -r)!
```

zfsu res (zfsres)
-----------------
**Usage**
```bash
$ zfsu res
Usage: zfsres <pool> <slow-mirror>
Enable slow mirror(s) and wait for them to be resilvered and exit.

Arguments:
  <pool>           - Name of the ZFS pool, e.g. tank
  <slow-mirror>    - Description of a slow mirror device, e.g. wwn-0x50004cf20c41a05b
```
