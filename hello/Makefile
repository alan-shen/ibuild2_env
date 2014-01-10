
ifneq ($(KERNELRELEASE),)
obj-m := hello.o
else
#KERNELDIR := /lib/modules/$(shell uname -r)/build
KERNELDIR := /home/b645/ibuild2_env/w32_ducati_v94/kernel
KERNELOUT := /home/b645/ibuild2_env/w32_ducati_v94/out/target/product/redhookbay/kernel_build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) O=$(KERNELOUT) modules
endif

clean:
	rm -f *.ko *.mod.c *.mod.o *.o
