DRIVERNAME := wch
all : modules

install : modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial
	depmod -a

ifneq ($(KERNELRELEASE),)
obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_devtable.o wch_serial.o wch_main.o
else
KDIR := /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)

modules:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -rf *.mk .tmp_versions Module.symvers *.mod.c *.o *.ko *.cmd Module.markers modules.order
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/$(DRIVERNAME).ko
endif
