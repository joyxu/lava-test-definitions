#!/bin/sh

#set -e
#set -x


dd if=/dev/random of=testR2 bs=4096 count=256k
md5sum testR2
for x in {1..10}; do cp testR2 testR2.$x; md5sum testR2.$x; done | cut -d ' ' -f 1 | uniq | wc -l
grep "1" result.log | tail -n 1 | awk '{print " pass"}'
lava-test-case-attach io-dd-md5 result.log

