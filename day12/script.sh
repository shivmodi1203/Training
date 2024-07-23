#!/bin/bash

file_list=$(ls)

for i in $file_list;
do
	echo $i
	exit 0
done
