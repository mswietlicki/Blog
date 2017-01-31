Title: Popping up SynKernelDiag on Ł
Autor: Mateusz Świetlicki
CreateDate: 2017-01-31 19:30
Tags:	Blog
		EN

Synaptics ClickPad V8.2 driver will save kernel logs on SHIFT + ALT + L key combination.
Luck would have it that the same combination is used on Polish keyboard to make letter "Ł".

So to avoid popping synaptics window you will need to disable driver debug DumpKernel in registry.

```
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SynTP\Parameters\Debug /v DumpKernel /d 00000000 /t REG_DWORD /f
```

Source:
[Dobre Programy](https://forum.dobreprogramy.pl/wyskakujace-logi-synkerneldiag-po-recznym-wpisaniu-wielkiej-litery-l-521745t/)