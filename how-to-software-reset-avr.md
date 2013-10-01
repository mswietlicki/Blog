Title: How to software reset AVR
Autor: Mateusz Œwietlicki
CreateDate: 2013-10-01 19:57
Tags: 	Blog
		EN
		AVR
		HomeIntelligence

To reset AVR uC like ATTiny85 from within your program you need simple to start Watchdog and let it timeout.

```C
	#include <avr/io.h>
	#include <avr/wdt.h>
	#define Reset_AVR() wdt_enable(WDTO_30MS); while(1) {}
```

Based on <http://support.atmel.com/bin/customer.exe?=&action=viewKbEntry&id=21>