#!/bin/bash

list_recursive()
{
    local filepath=$1
    local indent=$2

    echo "${indent}${filepath##*/}"

    if [ -d "$filepath" ]; then
        local fname

        _IFS=$IFS	# backup internal field separater(\ \t \n)
        IFS=$'\n'

        for fname in $(ls "$filepath")
        do
                list_recursive "${filepath}/${fname}" "   | $indent"
        done
    fi
}

list_recursive "$1" ""
IFS=$_IFS			# recover internal field separater(\ \t \n)