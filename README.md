# Driver for WCH PCI and PCIe bus to serial port and parallel port chips
## Description

This driver supports PCI interface chips CH351/CH352/CH353/CH355/CH356/CH357/CH358/CH359 and PCIe interface chips CH382/CH384. This driver supports Linux system versions with kernel version 2.6.0 and above.

In fact some chip types above were supported by 8250_pci and parport_serial driver, you can type "dmesg | grep ttyS" to find related tty devices and "ls /dev/lp*" to find the parport port devices.  

When use this vendor driver, the tty devices are named "/dev/ttyWCH*" and the parport port devices are still named "/dev/lp *" . And when this driver is successfully loaded, the system's built-in 8250_pci and parport_serial driver will automatically unbind. We suggest our customers use this driver cause it supports almost all advanced features.

1. Open "Terminal"
2. Type "sudo sh install.sh" to make the driver work permanently
3. Type "sudo sh uninstall.sh" to remove the driver
4. You can refer to the link below to acquire uart application, you can use gcc or Cross-compile with cross-gcc
   https://github.com/WCHSoftGroup/tty_uart

## Note

1. If you are using multi-ports card such as CH384 + CH438 * n to achieve mutli serial ports we recommend the following hardware combination and a dedicated PID. When using the following hardware solution, the chip needs to be connected to the EEPROM and a specified configuration file needs to be programmed. This file can be obtained from the manufacturer.

   PCIe to 8-port HighSpeed UART: CH384[S0-S3] + CH438[S2-S5] | PID: 0x4808

   PCIe to 10-port HighSpeed UART: CH384[S0-S3] + CH438[S1-S6] | PID: 0x480A

   PCIe to 16-port HighSpeed UART: CH384[S0-S3] + CH438#1[S1-S7] + CH438#2[S1-S5] | PID: 0x4810

   PCIe to 20-port UART: CH384 + CH438#1[S0-S7] + CH438#2[S0-S7] | PID: 0x4814

   If a user designs a multi-serial port card using a combination of CH384 and CH438 without noticing this instruction, a temporary solution is as follows:

   You can modify the uart amount variable "PCIE_UART_MAX" defined in wch_devtable.c at about line 3, modify the number 28 to the actual amount of serial ports. This method requires that the hardware design be a modified version of a 28-port serial card which the board ID must be 1c00:4353.

2. In this driver, the 22.1184M frequency is used to calculate the serial port baud rate by default. If other baud rates are required, the hardware needs to use other frequency crystal, and modify the crystal frequency variable "CRYSTAL_FREQ" defined in wch_common.h at about line 286. 

3. Normally the internal reference clock of the serial port(uartclk) is equal to 1/12 or twice the frequency of the external crystal. Serial port baud rate = uartclk / 16 / 16-bit baud rate divisor reg. When the reg is equal to 1, the maximum serial baud rate supported by the crystal can be calculated. Exp:

   when 22.1184MHz crystal is selected, baud rate(max) = 22.1184M * 2 / 16 / 1 = 2.7648Mbps.
   when 64MHz crystal is selected, baud rate(max) = 64M * 2 / 16 / 1 = 8Mbps.

4. If you are using an RS485 serial port card and are using the chip's DTR pin as the RS485 transmit/receive indicator switch, you can switch it by modifying the RS485 enable switch in wch_devtable.c. Taking the CH384 4-channel RS485 serial port card as an example:

   ```
   /* CH384_4S */
     {
        VENDOR_ID_WCH_PCIE,
        DEVICE_ID_WCH_CH384_4S,
        SUB_VENDOR_ID_WCH_PCIE,
        SUB_DEVICE_ID_WCH_CH384_4S,
        4,
        0,
        0xE9,
        0x00,
        0x00,
        0x00,
        "CH384_4S",
        BOARDFLAG_NONE,
        {
          { 's', 0, 0xC0, 8, -1, 0, 0, WCH_BOARD_CH384_4S,
           1 }, /* 1: Enable DTR0 to switch to RS485 direction control, 0: Disable */
          { 's', 0, 0xC8, 8, -1, 0, 0, WCH_BOARD_CH384_4S,
           1 }, /* 1: Enable DTR1 to switch to RS485 direction control, 0: Disable */
          { 's', 0, 0xD0, 8, -1, 0, 0, WCH_BOARD_CH384_4S,
           1 }, /* 1: Enable DTR2 to switch to RS485 direction control, 0: Disable */
          { 's', 0, 0xD8, 8, -1, 0, 0, WCH_BOARD_CH384_4S,
           1 }, /* 1: Enable DTR3 to switch to RS485 direction control, 0: Disable */
        },
     },
   ```

Any question, you can send feedback to mail: tech@wch.cn