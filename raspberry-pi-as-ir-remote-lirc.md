Title: Raspberry Pi as IR Remote (LIRC)
Autor: Mateusz �wietlicki
CreateDate: 2013-10-01 09:00
Tags: 	Blog
		EN
		RaspberryPi
		LIRC
		HomeIntelligence

If you are like me and hate to look for TV/projector/speakers remote, you will be happy to know that you can use your Raspberry Pi and your computer or phone to act as IR remote.

![IR Transmiter in action](/files/ir-transmiter-show.jpg)

What you need?
--------------

- Raspberry Pi
- 940nm IR diode (preferable super bright)
- 200 Ohm resistor
- NPN transistor (BC547 or S9014 or similar)
- Some jumper cables
- Decoded remote configuration from my previous post [Raspberry Pi as IR remote decoder (LIRC)
](http://mateusz.swietlicki.net/Post/raspberry-pi-as-ir-remote-decoder-lirc)

Setting up:
----------

You need to simple board and connect to GPIO 17 of your Raspberry Pi as in schematic:

![IR Transmiter schematic](/files/ir-transmiter.png)

![IR Transmiter picture](/files/ir-transmiter-picture.jpg)

Transistor is needed to increase our remote effective range. You can connect diode directly to GPIO but it will be to weak to be useful.
You can also use 5V to increase range.

Instalation:
-----------

Instalation is the same as in my IR decoder post [Raspberry Pi as IR remote decoder (LIRC)
](http://mateusz.swietlicki.net/Post/raspberry-pi-as-ir-remote-decoder-lirc).

```powershell
	sudo apt-get install lirc
	sudo echo 'lirc_dev' >> /etc/modules
	sudo echo 'lirc_rpi gpio_in_pin=18 gpio_out_pin=17' >> /etc/modules
	sudo wget http://raw.github.com/mswietlicki/Blog/master/Files/lirc_hardware.conf > /etc/lirc/hardware.conf
	sudo wget http://raw.github.com/mswietlicki/Lirc_remotes/master/benq.config -O /etc/lirc/lircd.conf
	sudo /etc/init.d/lirc restart
```

Testing:
--------

Now we can use irsend to send command to your device.

To send command once:

```powershell
	irsend SEND_ONCE benq ON
```

To send command many times:

```powershell
	irsend SEND_START benq ON
	sleep(1)
	irsend SEND_STOP benq ON
```

To list all commands:

```powershell
	irsend LIST benq ""
```

To list all install remotes:

```powershell
	irsend LIST "" ""
```

Referance: <http://www.lirc.org/html/irsend.html>

Web interface:
--------------

For web control you can try <http://ni-c.github.io/heimcontrol.js/>.
I however will be writing my own system.
