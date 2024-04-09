## root@ironblight:~# mount -t ntfs /dev/sdb1 /mnt/archlinux/
## Failed to read last sector (1953519614): Argumento inválido
## HINTS: Either the volume is a RAID/LDM but it wasn't setup yet,
##    or it was not setup correctly (e.g. by not using mdadm --build ...),
##    or a wrong device is tried to be mounted,
##    or the partition table is corrupt (partition is smaller than NTFS),
##    or the NTFS boot sector is corrupt (NTFS size is not valid).
## Failed to mount '/dev/sdb1': Argumento inválido
## The device '/dev/sdb1' doesn't seem to have a valid NTFS.
## Maybe the wrong device is used? Or the whole disk instead of a
## partition (e.g. /dev/sda, not /dev/sda1)? Or the other way around?

# Detalhes: dividi o HD externo em duas partições, após isso iniciou esse problema.

Solução: ntfsfix /dev/sdb1

