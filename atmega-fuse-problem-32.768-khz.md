Title: ATMega fuse mistake (Ext. 32.768kHz crystal oscillator)
Autor: Mateusz Świetlicki
CreateDate: 2013-11-22 17:06
Tags: 	Blog
		EN
		AVR
		HomeIntelligence

Recently I have moved my "LED Wings Poi" project from ATMega8 to ATMega1284P and I have made myself a little problem. I forgot to change fuse settings and program 1284P to lfuse=0xa4 and hfuse=0xd9. So what happened was uC set itself to Ext. Low-Freq. Crystal clock.
Full fuse table can by found on ![http://www.engbedded.com/fusecalc/].

Only way to fix it is to buy Low-Freq. Crystal clock. connect it to XTAL1 and XTAL2 pins and to ground through 2 x 20pF capasitors (one for one line) 

![ATTiny crystal connections](/files/32k.png)

and than use normaly use AVRDude to program your fuses back to originals:

```bash
sudo avrdude -p m1284p -c usbasp -P usb -t -B 125
sudo avrdude -p m1284p -c usbasp -P usb -U lfuse:w:0xd2:m -U hfuse:w:0x99:m -U efuse:w:0xfd:m -B 125
```