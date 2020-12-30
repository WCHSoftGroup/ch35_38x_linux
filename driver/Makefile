# Copyright 2006 - 2012  WCH Co., Ltd. all right reserved
# for kernel 2.6
ifeq "$(findstring 2.6, $(shell uname -a))" "2.6"
DRIVERNAME := wch
all:	modules

install: modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/char/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/char/
	mkdir -p /lib/modules/$(shell uname -r)/misc/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/misc/
	depmod -a
	
	
ifneq ($(KERNELRELEASE),)

obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_main.o wch_devtable.o wch_serial.o
else
KDIR	:= /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)


modules:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean: clean_local


endif


clean_local:
	rm -f *~
	rm -f *.o
	rm -rf ./.tmp_versions
	rm -f *.mod*
	rm -f *.ko
	rm -f .wch*
	rm -f $(DRIVERNAME)
	rm -f Module*
	rm -f module*
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).ko
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).ko
endif	

# for kernel 3.0
ifeq "$(findstring 3., $(shell uname -a))" "3."
DRIVERNAME := wch
all:	modules 

install: modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/char/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/char/
	mkdir -p /lib/modules/$(shell uname -r)/misc/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/misc/
	depmod -a
	
	
ifneq ($(KERNELRELEASE),)

obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_main.o wch_devtable.o wch_serial.o
else
KDIR	:= /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)


modules:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean: clean_local


endif


clean_local:
	rm -f *~
	rm -f *.o
	rm -rf ./.tmp_versions
	rm -f *.mod*
	rm -f *.ko
	rm -f .snx*
	rm -f $(DRIVERNAME)
	rm -f Module*
	rm -f module*
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).ko
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).ko
endif	

# for kernel 4.0
ifeq "$(findstring 4., $(shell uname -a))" "4."
DRIVERNAME := wch
all:	modules 

install: modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/char/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/char/
	mkdir -p /lib/modules/$(shell uname -r)/misc/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/misc/
	depmod -a
	
# for kernel 5.0
ifeq "$(findstring 5., $(shell uname -a))" "5."
DRIVERNAME := wch
all:	modules 

install: modules
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/char/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/char/
	mkdir -p /lib/modules/$(shell uname -r)/misc/
	cp -f ./$(DRIVERNAME).ko /lib/modules/$(shell uname -r)/misc/
	depmod -a

ifneq ($(KERNELRELEASE),)

obj-m += $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_main.o wch_devtable.o wch_serial.o
else
KDIR	:= /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)


modules:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean: clean_local


endif


clean_local:
	rm -f *~
	rm -f *.o
	rm -rf ./.tmp_versions
	rm -f *.mod*
	rm -f *.ko
	rm -f .snx*
	rm -f $(DRIVERNAME)
	rm -f Module*
	rm -f module*
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).ko
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).ko
endif	
	

# for kernel 2.4
ifeq "$(findstring 2.4, $(shell uname -a))" "2.4"
DRIVERNAME :=wch
CC=gcc -c

ARCH=$(shell uname -m | sed s/i.86/i86/)


ifeq	($(ARCH),i86)
PARMS= -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O2 \
-fomit-frame-pointer -I/lib/modules/$(shell uname -r)/build/include
else
PARMS= -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O2 \
-fomit-frame-pointer -pipe -I/lib/modules/$(shell uname -r)/build/include -ffixed-8
endif


ifeq	($(MAKECMDGOALS), install)
PARMS+= -DMODVERSIONS
endif


ifeq	"$(findstring SMP, $(shell uname -a))" "SMP"
PARMS+= -D__SMP__
endif


all:	wch.o

install: wch.o
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/char/
	cp -f ./$(DRIVERNAME).o /lib/modules/$(shell uname -r)/kernel/drivers/char/
	mkdir -p /lib/modules/$(shell uname -r)/misc/
	cp -f ./$(DRIVERNAME).o /lib/modules/$(shell uname -r)/misc/
	depmod -a

wch.o: wch_main.o wch_devtable.o wch_serial.o

	ld -r -o $@ $^



wch_main.o:
	$(CC) $(PARMS) wch_main.c

wch_devtable.o:
	$(CC) $(PARMS) wch_devtable.c

wch_serial.o:
	$(CC) $(PARMS) wch_serial.c

clean:
	rm -f *~
	rm -f *.o
	rm -rf ./.tmp_versions
	rm -f .snx_*
	rm -f $(DRIVERNAME).mod*
	rm -f $(DRIVERNAME).o
	rm -f $(DRIVERNAME)
	rm -f module*
	rm -f Module* 
	rm -f /lib/modules/$(shell uname -r)/kernel/drivers/char/$(DRIVERNAME).o
	rm -f /lib/modules/$(shell uname -r)/misc/$(DRIVERNAME).o
		
endif




