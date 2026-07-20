CONFIG_MODULE_SIG=n

PARPORT_ENABLE := $(shell \
    grep -qw parport_pc_probe_port /proc/kallsyms && \
    grep -qw parport_pc_unregister_port /proc/kallsyms && \
    echo 1 || echo 0)
ccflags-y += -DPARPORT_ENABLE=$(PARPORT_ENABLE)

KERNELDIR := /lib/modules/$(shell uname -r)/build

PWD :=$(shell pwd)

DRIVERNAME := ch35x_38x

obj-m := $(DRIVERNAME).o
$(DRIVERNAME)-y := wch_devtable.o wch_serial.o wch_main.o

# Default target
all:
	$(MAKE) -C $(KERNELDIR)  M=$(PWD) modules
	@echo "=== The target driver file has been generated ==="
	@ls -la *.ko*

# Check default driver compression format
CHECK_KO_XZ := $(shell find /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ -name "*.ko.xz" 2>/dev/null | head -n1)
CHECK_KO_ZSTD := $(shell find /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ -name "*.ko.zst" 2>/dev/null | head -n1)

ZSTD := zstd
ZSTD_OPTIONS := -T0

XZ := xz
XZ_OPTIONS := -T0

# Check if the compression tool exists
CHECK_ZSTD := $(shell command -v $(ZSTD) 2> /dev/null)
CHECK_XZ := $(shell command -v $(XZ) 2> /dev/null)

check-tools:
ifndef CHECK_ZSTD
	$(error "Error: Not found zstd tool, please install with: sudo apt install zstd")
endif
ifndef CHECK_XZ
	$(error "Error: Not found xz tool, please install with:: sudo apt install xz-utils")
endif

clean:
	@echo "=== Clean up the build files ==="
	$(MAKE) -C $(KERNELDIR)  M=$(PWD) clean
	rm -rf *.mk .tmp_versions Module.symvers *.mod.c *.o *.ko* .*.cmd Module.markers modules.order *.a *.mod

load:
	@echo "=== Dynamically loaded driver ==="
	insmod $(DRIVERNAME).ko

unload:
	@echo "=== Unloaded driver ==="
	rmmod $(DRIVERNAME)

install: all
	@echo "=== Install driver which support booting with the system... ==="
	insmod $(DRIVERNAME).ko || true
	mkdir -p /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ || true

ifneq ($(CHECK_KO_XZ),)
	@echo "=== KO_XZ driver install ===" 
	$(XZ) $(XZ_OPTIONS) -q -f -k $(DRIVERNAME).ko
	cp $(DRIVERNAME).ko.xz /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ || true

else ifneq ($(CHECK_KO_ZSTD),)
	@echo "=== KO_ZST driver install ==="
	$(ZSTD) $(ZSTD_OPTIONS) -q -f -k $(DRIVERNAME).ko
	cp $(DRIVERNAME).ko.zst /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ || true

else
	@echo "=== KO driver install ==="
	cp $(DRIVERNAME).ko /lib/modules/$(shell uname -r)/kernel/drivers/tty/serial/ || true
endif

	depmod -a
	@echo "=== Driver installation completed successfully ==="

FILE_NAME1=$(DRIVERNAME)
FILE_NAME2=wch
FILE_NAME3=ch35_38x
SEARCH_DIRS="/lib/modules/$(shell uname -r)/kernel/"

uninstall:
	@echo "=== Uninstall driver... ==="
	@rmmod $(DRIVERNAME) || true
	@rmmod wch || true

	@for dir in $(SEARCH_DIRS); do     \
	    if [ -d "$$dir" ]; then      \
	        find "$$dir" \( -name "$(FILE_NAME1).*" -o -name "$(FILE_NAME2).*" -o -name "$(FILE_NAME3).*" \) 2>/dev/null | while read file; do   \
	            rm -f "$$file";      \
	        done \
	    fi \
	done

	depmod -a
	@echo "=== Driver uninstallation completed successfully ==="
	
.PHONY: all check-tools load unload install uninstall clean
