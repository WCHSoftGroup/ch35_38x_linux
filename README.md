# ch35_38x_linux serial driver
## Description

This driver supports pci to uart chips ch351/ch352/ch353/ch355/ch356/ch357/ch358/ch359, pcie to uart chips ch382/ch384.
In fact most chip types above were supported by 8250_pci and parport_serial driver, you can type "dmesg | grep ttyS" to find related tty devices.  
When use this vendor driver, the tty devices are named "ttyWCH*". We suggest our customers use this driver cause it supports almost all advanced features.

1. Open "Terminal"
2. Type "sudo sh install.sh" to make the driver work permanently
3. Type "sudo sh uninstall.sh" to remove the driver
4. You can refer to the link below to acquire uart application, you can use gcc or Cross-compile with cross-gcc
   https://github.com/WCHSoftGroup/tty_uart

## Note

1. If you are using multi-ports card such as CH384 + CH438 * n to achieve 12/16/20 serial ports etc. You can modify the uart amount variable "PCIE_UART_MAX" defined in wch_devtable.c at about line 3, modify the number 28 to the actual amount of serial ports. However, we recommend the following hardware combination and a dedicated PID.
   
   PCIe to 8-port HighSpeed UART: CH384[S0-S3] + CH438[S2-S5] | PID: 0x4808
   
   PCIe to 10-port HighSpeed UART: CH384[S0-S3] + CH438[S1-S6] | PID: 0x480A
   
   PCIe to 16-port HighSpeed UART: CH384[S0-S3] + CH438#1[S1-S7] + CH438#2[S1-S5] | PID: 0x4810
   
   PCIe to 20-port UART: CH384 + CH438#1[S0-S7] + CH438#2[S0-S7] | PID: 0x4814
   
2. In this driver, the 22.1184M frequency is used to calculate the serial port baud rate by default. If other baud rates are required, the hardware needs to use other frequency crystal, and modify the crystal frequency variable "CRYSTAL_FREQ" defined in wch_common.h at about line 273. 

3. The internal reference clock of the serial port(uartclk) is equal to 1/12 or twice the frequency of the external crystal. Serial port baud rate = uartclk / 16 / 16-bit baud rate divisor reg. When the reg is equal to 1, the maximum serial baud rate supported by the crystal can be calculated. Exp:

when 22.1184MHz crystal is selected, baud rate(max) = 22.1184M * 2 / 16 / 1 = 2.7648Mbps.
when 64MHz crystal is selected, baud rate(max) = 64M * 2 / 16 / 1 = 8Mbps.

Any question, you can send feedback to mail: tech@wch.cn
