Title: Raspberry Pi as IR remote decoder (LIRC)
Autor: Mateusz Œwietlicki
CreateDate: 2013-09-25 09:39
Tags: 	Blog
		EN
		RaspberryPi
		LIRC
		HomeIntelligence

As part of my dream to build automatisation and remote control system in my flat I needed to decode IR remotes for my projector and speakers. Thanks to that later I will by able to control them easily from Raspberry Pi or AVR µC.

What you need?
-------------

- Raspberry Pi
- IR receiver TSOP2236 36kHz (or similar)

Setting up:
----------

For LIRC to work properly with IR receiver you need to connect:
- RPi 3.3 to TSOP2236 pin 2 (Vs)
- RPi GND to TSOP2236 pin 3 (GND)
- RPi GPIO 18 to TSOP2236 pin 1 (OUT)

*Remember to check your IR Receiver datasheet for pins numbers conformation.*

Instalation:
------------

To install Lirc on your Raspberry Pi use my quick instalation or read detail instactions on [this blog](http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/).

```bash
	sudo apt-get install lirc
	sudo echo 'lirc_dev' >> /etc/modules
	sudo echo 'lirc_rpi gpio_in_pin=18 gpio_out_pin=17' >> /etc/modules
	sudo wget 'http://raw.github.com/mswietlicki/Blog/master/Files/lirc_hardware.conf' > /etc/lirc/hardware.conf
	sudo wget http://lirc.sourceforge.net/remotes/benq/MP620 -O /etc/lirc/lircd.conf
	sudo /etc/init.d/lirc restart
```

Testing:
--------

To test if receiver works properly you can look at raw data passing from /dev/lirc0.

```bash
	sudo /etc/init.d/lirc stop
	mode2 -d /dev/lirc0
```

*Attention: to read from /dev/lirc0 you need to stop lirc service.*

Recording:
----------

To record your IR remote codes you can use irrecord:

```bash
	sudo /etc/init.d/lirc stop
	irrecord -d /dev/lirc0 --disable-namespace Remote.raw
	irrecord -a Remote.raw Remote.conf
```

Loading remote configuration:
-----------------------------

To load remote configuration you need to replace **/etc/lirc/lircd.conf** file.

```bash
	sudo cp Remote.conf /etc/lirc/lircd.conf
	sudo /etc/init.d/lirc restart
```

You can also look for predefine configuration for your remote on [http://lirc.sourceforge.net/remotes](http://lirc.sourceforge.net/remotes).


References:
-----------

(http://lirc.sourceforge.net/remotes/benq/MP620)
(http://manpages.ubuntu.com/manpages/lucid/man1/irsend.1.html)
(http://www.lirc.org/html/irsend.html)
(http://wiki.openelec.tv/index.php?title=Guide_To_lirc_rpi_GPIO_Receiver)
(http://wiki.xbmc.org/index.php?title=How-to:Setup_Lirc)
(http://randomtutor.blogspot.gr/2013/01/web-based-ir-remote-on-raspberry-pi.html)
(http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/)