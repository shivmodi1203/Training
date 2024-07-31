#!/bin/bash

for i in $(ls);
do
    if [ -d ${i} ];
    then
        mv ${i}/*.md ${i}/README.md
    fi
done