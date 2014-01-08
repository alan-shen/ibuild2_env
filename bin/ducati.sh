#!/bin/bash

BINPATH=$HOME/ibuild2_env/bin

BASE_DIR=$HOME/ibuild2_env/w32_ducati_v94
PROD_DIR=$HOME/ibuild2_env/devr4tw32
SPEC_NAME=spec_w32_DUCATI.conf

# make ibuild2 build process(integrate your configs in ibuild2 to your base line)
echo -e "\n\n\n>>>>>>>>>> INTEGRATE IBUILD2 CONFIG TO BASE LINE  <<<<<<<<<<"
hb $BASE_DIR $PROD_DIR $SPEC_NAME $1 $2 $3 $4 $5 $6 $7 $8 $9
if [ $? == 0 ];then 

	pushd ${PROD_DIR}
	${PROD_DIR}/clean_hbtmp.sh
	popd

	pushd $BASE_DIR > /dev/null

	# apply a patch for ignore .svn in findleaves.py/find/grep
	echo -e "\n\n\n>>>>>>>>>> APPLY PATH IGNORE .SVN DIRECTORY <<<<<<<<<<"
	if [ -e $HOME/bin/find_ex ];then alias find=find_ex;echo "use find_ex as find";fi
	if [ -e $HOME/bin/grep_ex ];then alias grep=grep_ex;echo "use grep_ex as grep";fi
	svn revert $BASE_DIR/build/tools/findleaves.py
	patch -p0 < ${BINPATH}/findleaves_prune_svn.patch
	patch -p0 < ${BINPATH}/patch_show_kernel_build_info.patch
	cp -rfv $BINPATH/platform_focaltech.c $BASE_DIR/kernel/arch/x86/platform/intel-mid/device_libs/platform_focaltech.c

	# create change list first(for that you can clean your base line quickly use script "restore_codebase.sh")
	echo -e "\n\n\n>>>>>>>>>> CREATE CHANGELIST FOR RESTORE(CLEAN) MAY NEED 6'MINUTE  <<<<<<<<<<"
	${BASE_DIR}/create_changelist.sh

	# build
	echo -e "\n\n\n>>>>>>>>>> ANDROID FULL BUILD PROCESS  <<<<<<<<<<"
	source build/envsetup.sh
	lunch 19
	START=`date`;make flashfiles -j8;echo $START;date
	#START=`date`;make bootimage -j8;echo $START;date
	REV_BASE=`svn info $BASE_DIR | grep Revision | awk -F' ' '{print $2}'`
	REV_IBUILD=`svn info $PROD_DIR | grep Revision | awk -F' ' '{print $2}'`
	#${OUT}/lfstk/main.sh -p DUCATI
	echo -e "\n\n=========================================="
	echo -e "  Base Version: $REV_BASE || $BASE_DIR"
	echo -e "IBUILD Version: $REV_IBUILD || $PROD_DIR"
	echo -e "==========================================\n\n"
	popd > /dev/null
fi
