#!/bin/bash

rm temp
touch temp
while read line
do
	echo $line | grep --color ".svn"
	if [ $? != 0 ]
	then
		echo $line >> temp
	fi
done < filelist

