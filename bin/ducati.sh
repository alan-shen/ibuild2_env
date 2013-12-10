#!/bin/bash

BINPATH=$HOME/ibuild2_env/bin

BASE_DIR=$HOME/ibuild2_env/w32_ducati_v94
PROD_DIR=$HOME/ibuild2_env/devr4tw32
SPEC_NAME=spec_w32_DUCATI.conf

# make ibuild2 build process(integrate your configs in ibuild2 to your base line)
echo -e "\n\n\n>>>>>>>>>> INTEGRATE IBUILD2 CONFIG TO BASE LINE  <<<<<<<<<<"
hb $BASE_DIR $PROD_DIR $SPEC_NAME $1 $2 $3 $4 $5 $6 $7 $8 $9
if [ $? == 0 ];then 
	pushd $BASE_DIR > /dev/null

	# apply a patch for ignore .svn in findleaves.py/find/grep
	alias find=find_ex
	alias grep=grep_ex
	patch -p0 < ${BINPATH}/findleaves_prune_svn.patch

	# create change list first(for that you can clean your base line quickly use script "restore_codebase.sh")
	echo -e "\n\n\n>>>>>>>>>> CREATE CHANGELIST FOR RESTORE(CLEAN) MAY NEED 6'MINUTE  <<<<<<<<<<"
	create_changelist.sh

	# build
	echo -e "\n\n\n>>>>>>>>>> ANDROID FULL BUILD PROCESS  <<<<<<<<<<"
	source build/envsetup.sh
	lunch 19
	START=`date`;make flashfiles -j2;echo $START;date
	START=`date`;make bootimage -j2;echo $START;date
	REV_BASE=`svn info $BASE_DIR | grep Revision | awk -F' ' '{print $2}'` && echo $REV_BASE > $BASE_DIR/.svnversion
	REV_IBUILD=`svn info $PROD_DIR | grep Revision | awk -F' ' '{print $2}'` && echo $REV_IBUILD > $PROD_DIR/.svnversion
	echo -e "\n\n=========================================="
	date
	echo -e "  Base Version: $REV_BASE || $BASE_DIR"
	echo -e "IBUILD Version: $REV_IBUILD || $PROD_DIR"
	echo -e "==========================================\n\n"
	popd > /dev/null
fi
