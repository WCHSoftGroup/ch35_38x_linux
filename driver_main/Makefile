CONFIG_MODULE_SIG=n

DRIVERNAME := wch
all : modules

ifneq ($(KERNELRELEASE),)
obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_devtable.o wch_serial.o wch_main.o
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
	insmod $(DRIVERNAME).ko || true
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial || true
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial || true
	@/bin/echo -e "wch" >> /etc/modules || true
	depmod -a
uninstall:
	rmmod $(DRIVERNAME) || true
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/$(DRIVERNAME).ko || true
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).ko || true
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).ko || true
	depmod -a
endif
