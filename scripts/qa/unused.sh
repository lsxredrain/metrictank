#!/bin/bash
# find the dir we exist within...
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# and cd into root project dir
cd ${DIR}/../..
#which unused &>/dev/null || go get -u honnef.co/go/tools/...
#which varcheck &>/dev/null || go get github.com/opennota/check/cmd/varcheck
#which structcheck &>/dev/null || go get github.com/opennota/check/cmd/structcheck
# for https://github.com/remyoudompheng/go-misc/pull/14
which deadcode &>/dev/null || go get -u github.com/Dieterbe/go-misc/deadcode

ret=0

# temporarily commented becaused the repo of "unused" is broken. uncomment once it is fixed
#echo "## running unused"
#unused .
#r=$?
#[ $r -gt $ret ] && ret=$r

# temporarily commented because a commit on the 31th of July also broke those two
#echo "## running varcheck"
#varcheck
#r=$?
#[ $r -gt $ret ] && ret=$r

#echo "## running structcheck"
#structcheck
#r=$?
#[ $r -gt $ret ] && ret=$r

echo "## running deadcode"
deadcode -test $(find . -type d | grep -v '.git' | grep -v vendor | grep -v docker)
r=$?
[ $r -gt $ret ] && ret=$r

[ $ret -eq 0 ] && echo "all good"
exit $ret
