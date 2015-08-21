Spark firmware
==============

Main source of information:
[https://github.com/spark/firmware](https://github.com/spark/firmware)

Lastest firmware:
[https://github.com/spark/firmware/releases/latest](https://github.com/spark/firmware/releases/latest)
[core-firmware.bin](https://github.com/spark/firmware/releases/download/spark_11/core-firmware.bin)

Test sprak usb DFU Mode:
```
	dfu-util -l
```

Flash firmware:
```
	dfu-util -d 1d50:607f -a 0 -s 0x08005000:leave -D core-firmware.bin
```

Spark deep reset: ("Deep update")
```
	spark flash --usb deep_update_2014_06
```