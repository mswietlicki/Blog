Title: ATTiny85 sleep mode
Autor: Mateusz Świetlicki
CreateDate: 2014-05-18 19:40
Tags:	Blog
		EN
		Electronics
		AVR

Lately I found myself in need to reduce power consumption of my LED Staff AVR controller while idle.

ATTiny85 have 3 sleep modes: Idle, ADC Noise Reduction and Power-down. Power-down (SLEEP\_MODE\_PWR_DOWN) will stop internal clock and everything other than Watchdog, INT0 and Pin Change (PCINTx). In this mode AVR consumes less power than I can measure (less than 0.1mA).

To switch to sleep mode use this code: 
```C
void SystemSleep() {
	sei();
  	set_sleep_mode(SLEEP_MODE_PWR_DOWN); // sleep mode is set here
  	sleep_enable();

  	sleep_mode();                        // System actually sleeps here

  	sleep_disable();                     // System continues execution here when watchdog timed out 
  	cli();
}
```

Also you need to define way to wakeup AVR. I used PCINT4 (Pin 4 Change).

```C
	SetBit(GIMSK, PCIE, 1); // Turn on Pin Change interrupt
	SetBit(PCMSK, PCINT4, 1); // Which pins are affected by the interrupt
```

One more thing you need to do is to write code that will catch to interrupt. If you don't do this AVR will fall to first line of code that is main() and "reset" your program.

```C
ISR(PCINT0_vect) { //Needed for sleep to not reset program after PCINT
  
}
```

Note: Every PCINTx will rise PCINT0_vect;