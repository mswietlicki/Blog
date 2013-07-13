Title: Windows Serwer 2008 R2 PortMapping
Autor: Mateusz Świetlicki
CreateDate: 2011-07-11 12:10
Tags: 	Blog
		.NET
		WCF

```powershell
netsh routing ip nat add portmapping external tcp 0.0.0.0 5555 192.168.0.2 3389 netsh routing ip nat show interface
```