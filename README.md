# ch35_38x_linux serial driver
Description:  
	This driver supports pci to uart chips ch351/ch352/ch353/ch355/ch356/ch357/ch358/ch359, pcie to uart chips ch382/ch384.  
	In fact the chip types above were supported by 8250_pci and parport_serial driver, you can type "dmesg | grep ttyS" to find related tty devices.  
	Also you can use this specific driver, the tty devices are named "ttyWCHx".  

1. open "Terminal"

2. cd "driver" directory

3. compile the driver using "make", you will see the module "wch.ko" if successful

4. "insmod wch.ko" to load the driver dynamically

5. "make install" to make the driver work permanently

6. you can refer to the link below to acquire uart application, you can use gcc or Cross-compile with cross-gcc
   https://github.com/WCHSoftGroup/tty_uart

Note:  
	If you are using multi-ports card such as CH384 + CH438 * n to achieve 12/16/20 serial ports etc.  
	You can modify the number in array "wch_pci_board_conf" in wch_devtable.c, at about line 321 which relates to CH384_28S, modify the number 28 to the actual amount of serial ports.
