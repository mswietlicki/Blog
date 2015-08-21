hdmi_force_hotplug=1

hdmi_group=2
hdmi_mode=85

sudo rpi-update

wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -

sudo nano /etc/apt/sources.list

# Mopidy APT archive
deb http://apt.mopidy.com/ stable main contrib non-free
deb-src http://apt.mopidy.com/ stable main contrib non-free

sudo apt-get install mopidy
apt-cache search mopidy
sudo apt-get install mopidy-spotify
sudo apt-get install mopidy-spotify-tunigo

sudo nano /etc/mopidy/mopidy.conf

[mpd]
enabled = true
hostname = 0.0.0.0
port = 6600

sudo apt-get install proftpd
sudo nano /etc/proftpd/proftpd.conf
sudo service proftpd restart

sudo apt-get install transmission-daemon
mkdir -p /home/pi/incomplete
mkdir /home/pi/complete
mkdir /home/pi/watch

sudo usermod -a -G debian-transmission pi
sudo chgrp debian-transmission /home/pi/incomplete
sudo chgrp debian-transmission /home/pi/complete
sudo chgrp debian-transmission /home/pi/watch
sudo chmod 770 /home/pi/incomplete
sudo chmod 770 /home/pi/complete
sudo chmod 770 /home/pi/watch
sudo service transmission-daemon reload


curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y build-essential python-dev python-rpi.gpio nodejs


sudo apt-get install bluez pulseaudio-module-bluetooth python-gobject python-gobject-2 bluez-tools
sudo usermod –a –G lp pi