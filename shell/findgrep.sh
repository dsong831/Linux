#!/bin/bash

if [ "$#" -ea 0 ]; then			# check count of command line arguments
    exit 1
fi

pattern=$1
directory=$2
name=$3

if [ -z "$directory" ]; then	# check directory then current directory
    directory='.'
fi

if [ -z "$name" ]; then			# check name then all name
    name='*'
fi

if [ ! -d "$directory" ]; then
    echo "$0: ${directory}: No such directory" 1>&2
    exit 2
fi

find "$directory" -type f -name "$name" | xargs grep -nH "$pattern"