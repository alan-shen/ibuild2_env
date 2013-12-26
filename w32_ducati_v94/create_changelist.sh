#!/bin/bash

# Define Pars Of Color Output
GP="\033[32;49;1m"
GE="\033[39;49;0m"
RP="\033[31;49;1m"
RE="\033[31;49;0m"
BP="\033[34;49;1m"
BE="\033[34;49;0m"
AP="\033[36;49;1m"
AE="\033[36;49;0m"

IGNORE_LIST="out pub filelist restore_codebase.sh change_list.txt change_list.txt.temp create_changelist.sh quickMakeImage kernel/cscope.out kernel/tags tags cscope.out LOCAL_MODULE removesvn.sh"

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
			echo -e "\t\t${RP}--${RE} ${line} | ${RP}Ignore To Clean${RE}"
			VUSE="false"
			break
		fi
	done
	if [ "$VUSE" == "true" ];then
		echo -e "\t\t${GP}++${GE} ${line}"
		echo ${line} >> change_list.txt
	fi
done < ${YOURIBUILD2PATH}/change_list.txt.temp
rm -rfv ${YOURIBUILD2PATH}/change_list.txt.temp 
popd > /dev/null
date
#}
