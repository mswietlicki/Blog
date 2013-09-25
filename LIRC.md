http://lirc.sourceforge.net/remotes/benq/MP620

sudo wget http://lirc.sourceforge.net/remotes/benq/MP620 -O /etc/lirc/lircd.conf

irrecord -d /dev/lirc0

irrecord -d /dev/lirc0 /benq.conf

http://manpages.ubuntu.com/manpages/lucid/man1/irsend.1.html

http://www.lirc.org/html/irsend.html

http://wiki.openelec.tv/index.php?title=Guide_To_lirc_rpi_GPIO_Receiver

http://wiki.xbmc.org/index.php?title=How-to:Setup_Lirc

http://randomtutor.blogspot.gr/2013/01/web-based-ir-remote-on-raspberry-pi.html

http://alexba.in/blog/2013/01/06/setting-up-lirc-on-the-raspberrypi/