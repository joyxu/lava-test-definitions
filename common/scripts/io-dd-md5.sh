#!/bin/sh

#set -e
#set -x

. include/sh-test-lib

TEST="io dd consistent testing"

dd if=/dev/urandom of=testR2 bs=4096 count=256k
md5sum testR2
for x in {1..10}; do cp testR2 testR2.$x; md5sum testR2.$x; done | tee result.log
	index=$(cut -d ' ' -f 1 < result.log | uniq | wc -l)
if [ "$index" = "1" ]; then
    pass_test
else
    fail_test "data is not consistent"
    return 1
fi
exit 0
