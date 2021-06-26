# ch35_38x_linux serial driver

Description:  
	This driver supports pci to uart chips ch351/ch352/ch353/ch355/ch356/ch357/ch358/ch359, pcie to uart chips ch382/ch384.  
	In fact most chip types above were supported by 8250_pci and parport_serial driver, you can type "dmesg | grep ttyS" to find related tty devices.  
	Also you can use this specific driver, the tty devices are named "ttyWCHx".  

1. Open "Terminal"
2. Switch to "driver" directory
3. Compile the driver using "make", you will see the module "wch.ko" if successful
4. Type "sudo make load" or "sudo insmod wch.ko" to load the driver dynamically
5. Type "sudo make unload" or "sudo rmmod wch.ko" to unload the driver
6. Type "sudo make install" to make the driver work permanently
7. Type "sudo make uninstall" to remove the driver
8. You can refer to the link below to acquire uart application, you can use gcc or Cross-compile with cross-gcc
   https://github.com/WCHSoftGroup/tty_uart

Note:  

 1. If you are using multi-ports card such as CH384 + CH438 * n to achieve 12/16/20 serial ports etc.  You can modify the maximum uart amount varible "PCIE_UART_MAX" in wch_devtable.c at about line 3, modify the number 28 to the actual amount of serial ports.

 2. In this driver, the 22.1184M frequency is used to calculate the serial port baud rate by default. If other baud rates are required, the hardware needs to use other frequency crystal, and modify the crystal frequency variable "CRYSTAL_FREQ" defined in common.h at about line 258. 

 3. The internal reference clock of the serial port(uartclk) is equal to 1/12 or twice the frequency of the external crystal. Serial port baud rate = uartclk / 16 / 16-bit baud rate divisor reg. When the reg is equal to 1, the maximum serial baud rate supported by the crystal can be calculated. Exp:

    when 22.1184MHz crystal is selected, baud rate(max) = 22.1184M * 2 / 16 / 1 = 2.7648Mbps.

    when 64MHz crystal is selected, baud rate(max) = 64M * 2 / 16 / 1 = 8Mbps.

