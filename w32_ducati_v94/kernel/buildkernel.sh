#!/bin/bash

#TARGET_TOOLS_PREFIX="/home/b645/ibuild2_env/w32_ducati_v94/prebuilts/gcc/linux-x86/x86/i686-linux-android-4.6/bin/i686-linux-android-" TARGET_DEVICE="redhookbay" TARGET_BOARD_PLATFORM="clovertrail" KERNEL_SRC_DIR="kernel" DIFFCONFIGS="" KERNEL_DIFFCONFIG_DIR="vendor/intel/clovertrail/board/redhookbay" PRODUCT_OUT=`pwd`/out/target/product/redhookbay vendor/intel/support/kernel-build.sh  -o get_kernel_from_source

echo -e "##### Build Kernel(bzImage) #####"
make ARCH=i386 O=/home/b645/ibuild2_env/w32_ducati_v94/out/target/product/redhookbay/kernel_build ANDROID_TOOLCHAIN_FLAGS=-mno-android -j8 bzImage
#echo -e "\n\n##### Build Modules         #####"
#make ARCH=i386 O=/home/b645/ibuild2_env/w32_ducati_v94/out/target/product/redhookbay/kernel_build ANDROID_TOOLCHAIN_FLAGS=-mno-android -j8 modules



#make ARCH=i386 O=/home/b645/ibuild2_env/w32_ducati_v94/out/target/product/redhookbay/kernel_build ANDROID_TOOLCHAIN_FLAGS=-mno-android menuconfig
