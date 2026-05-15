#!/bin/bash

./make_dirs.sh

local_only=false
if [ "${1:-}" = "--local" ]; then
    local_only=true
fi

error=""

if [ "$local_only" = true ]; then
    tests="local_simple.sh local_nest.sh local_relative.sh"
else
    tests="local_simple.sh remote_dest.sh remote_src.sh remote_both.sh local_nest.sh local_relative.sh"
fi

for t in $tests
do
    ./$t
    if [ $? -ne 0 ]; then error=true; fi
done

if [ -n "$error" ]; then
    echo "" >&2
    echo "ERROR: Some tests failed" >&2
    exit -1
fi

echo ""
echo "All tests passed!"
