#!/bin/bash

IGNORE_LIST="out pub filelist restore_codebase.sh change_list.txt change_list.txt.temp create_changelist.sh"

YOURIBUILD2PATH=`pwd`

#main{
date
pushd ${YOURIBUILD2PATH} > /dev/null

rm -rfv ${YOURIBUILD2PATH}/change_list.txt.temp 
svn status > ${YOURIBUILD2PATH}/change_list.txt.temp
rm -rfv ${YOURIBUILD2PATH}/change_list.txt
touch ${YOURIBUILD2PATH}/change_list.txt

while read line
do
	VUSE="true"
	VLINE=`echo $line | awk -F' ' '{print $2}'`
	for VIGNORE in $IGNORE_LIST
	do
		if [ "${VLINE}" == "${VIGNORE}" ]
		then
			echo -e "\t\t-- ${VIGNORE} | ${VIGNORE}"
			VUSE="false"
			break
		fi
	done
	if [ "$VUSE" == "true" ];then
		echo -e "\t\t++ ${line}"
		echo ${line} >> change_list.txt
	fi
done < ${YOURIBUILD2PATH}/change_list.txt.temp
rm -rfv ${YOURIBUILD2PATH}/change_list.txt.temp 
popd > /dev/null
date
#}
