DRIVERNAME := wch_pre
all : modules

ifneq ($(KERNELRELEASE),)
obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_pre_main.o
else
KERNELDIR := /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)

modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	rm -rf *.mk .tmp_versions Module.symvers *.mod* *.o *.ko .wch* Module.markers modules.order .*.cmd
load:
	insmod $(DRIVERNAME).ko
unload:
	rmmod $(DRIVERNAME)
install : modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial
	depmod -a
uninstall:
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/$(DRIVERNAME).ko
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).ko
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).ko
	depmod -a
endif
