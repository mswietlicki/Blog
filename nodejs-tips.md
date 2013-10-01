Title: Node.js tips
Autor: Mateusz Œwietlicki
CreateDate: 2013-08-21 09:39
Tags: 	

dir -r | ForEach-Object { $_.FullName.Replace('C:\Code\Nodejs\testProject\', '') } | ForEach-Object { '<Content Include="' + $_ + '"><SubType>Content</SubType></Content>' }

wget --no-check-certificate https://registry.npmjs.org/coffee-script/-/coffee-script-1.3.3.tgz



UWAGA: 
Node-i2c nie dzia³¹ dobrze je¿eli u¿ytkownik nie jest w grupie i2c:
Poprawka:
	sudo adduser pi i2c

Mia³em te¿ problem z zapisywaniem u¿ywaj¹c node-i2c. 
Problem w koñcu rozwi¹za³em wpisuj¹c:
	wire.writeBytes(0x00,[0x01], function(err) {});


http://www.robot-electronics.co.uk/acatalog/I2C_Tutorial.html

https://github.com/nomadas/i2c_slave/blob/master/i2c_slave.h

http://blog.oscarliang.net/raspberry-pi-arduino-connected-i2c/

http://sci.tech-archive.net/Archive/sci.electronics.design/2006-09/msg01453.html

http://www.engineersgarage.com/embedded/avr-microcontroller-projects/atmega32-twi-two-wire-interface

https://github.com/kelly/node-i2c

http://people.ece.cornell.edu/land/courses/ece4760/FinalProjects/s2012/bdt25_edr46/bdt25_edr46/source/i2c.h

http://yfc58.wordpress.com/2013/03/29/raspberry-pi-change-i2c-baudrate-to-400khz/

$ sudo nano /etc/modprobe.d/i2c.conf
options i2c_bcm2708 baudrate=400000

lub:

sudo modprobe -r i2c_bcm2708 && sudo modprobe i2c_bcm2708 baudrate=400000

http://www.skpang.co.uk/blog/archives/575

http://mikehw.rddev.co.uk/?cat=6

sudo apt-get install gcc-avr avr-libc avrdude


#!/bin/bash
if [ -z $1 ]; then
 echo "Usage $0 <source.c>"
 exit
fi
FILE=$(echo $1 | sed 's/\..*//')
rm $FILE.o $FILE.elf $FILE.hex
avr-gcc -Os -DF_CPU=1000000UL -mmcu=atmega8 -c -o $FILE.o $1
avr-gcc -mmcu=atmega8 $FILE.o -o $FILE.elf
avr-objcopy -O ihex -R .eeprom $FILE.elf $FILE.hex
sudo avrdude -p m8 -c usbasp -P usb -U flash:w:$FILE.hex
