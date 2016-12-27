```
#First find out some information;
#Assume disk we will use it sdb
cat /sys/block/sdb/queue/optimal_io_size
1048576
cat /sys/block/sdb/alignment_offset
0
cat /sys/block/sdb/queue/physical_block_size
512

#Let's make some calculation;
Formula -> (optimal_io_size + alignment_offset)/physical_block_size
Assume for this example;
(1048576 + 0) / 512 = 2048

parted /dev/sdb
mklabel gpt
mkpart primary 2048s 100%
align-check optimal 1
#Then you will seei first partition aligned
1 aligned
```
