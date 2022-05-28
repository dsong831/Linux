#!/bin/bash

if [ "$#" -ea 0 ]; then    # check count of command line arguments
    exit 1
fi

pattern=$1
directory=$2
name=$3

if [ -z "$directory" ]; then    # check directory then current directory
    directory='.'
fi

if [ -z "$name" ]; then    # check name then all name
    name='*'
fi

if [ ! -d "$directory" ]; then
    echo "$0: ${directory}: No such directory" 1>&2
    exit 2
fi

find "$directory" -type f -name "$name" | xargs grep -nH "$pattern" >> rawdata.txt

###################################
# awk script
awk -F : 'BEGIN{
DB[0][0]="PATH"
DB[0][1]="FILENAME"
DB[0][2]="TESTNAME"
DB[0][3]="ALL_PARAMETER"
DB[0][4]="GROUP"
DB[0][5]="TEST_FW"
DB[0][6]="KNOBS"
DB[0][7]="CC_ARGS"
DB[0][8]="SIM_ARGS"}

{
DB[NR][0]=$1
DB[NR][1]=(basename $1)
DB[NR][2]=$3
DB[NR]]3]=$NF

index_array[4]=index($NF, "group=")
index_array[5]=index($NF, "test=")
index_array[6]=index($NF, "knobs=")
index_array[7]=index($NF, "cc_args=")
index_array[8]=index($NF, "sim_args=")

for(i=4; i<9; i++)
{
	if(index_array[i]
	{
		DB[NR][i]=substr($NF, index_array[i], 10)
	}
	else
	{
		DB[NR][i]=0
	}
}
}

END{
for(i=0; i<NR+1; i++)
{
	print DB[i][0]";"DB[i][1]";"DB[i][2]";"DB[i][3]";"
}
}' rawdata.txt > testlist.csv

rm rawdata.txt
