#!/bin/bash

file=$1
max_requests=$2

directory=$3

# read ips from file
# and store it to an
# array
i=0
while IFS= read line; do
	ips[$i]=$line
	i=$(($i + 1))
done <"$file"

# create the commands
i=0
for ip in "${ips[@]}"; do
	commands[$i]="ping -c $max_requests $ip"
	i=$(($i + 1))
done

# execute the commands
# and pipe them to files
i=0
for command in "${commands[@]}"; do
	eval "$command 2>>1 | tee '$directory/${ips[i]}.txt'"
	echo "${command} DONE"
	i=$(($i + 1))
done
