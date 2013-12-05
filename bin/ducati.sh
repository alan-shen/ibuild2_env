#!/bin/bash

BASE_DIR=/home/b645/ibuild2/devr4tw32
PROD_DIR=/home/b645/ibuild2/w32_ducati


SPEC_NAME=spec_w32_DUCATI.conf


hb $BASE_DIR $PROD_DIR $SPEC_NAME $1 $2 $3 $4 $5 $6 $7 $8 $9

# build
pushd $BASE_DIR
source build/envsetup.sh
lunch 19
make flashfiles -j4
REV_BASE=`svn info $BASE_DIR | grep Revision | awk -F' ' '{print $2}'`
REV_IBUILD=`svn info $PROD_DIR | grep Revision | awk -F' ' '{print $2}'`
date
echo -e "  Base Version: $REV_BASE | $BASE_DIR"
echo -e "IBUILD Version: $REV_IBUILD | $PROD_DIR"
popd
