Title: Exchange 2010 - The WinRM client received an HTTP server error status (500)
Autor: Mateusz Świetlicki
CreateDate: 2010-04-15 00:41
Tags: 	Blog
		.NET
		WCF

Exchange 2010 - The WinRM client received an HTTP server error status (500)
===========

Natknąłem się ostatnio znów na problem z serwerem Exchange 2010 stojącym na wirtualnym WS2008R2. Przy próbie połączenia z konsolą exchange wyświetlał się komunikat błędu:

```
Connecting to remote server failed with the following error message : The WinRM client received an HTTP server error status (500), but the remote service did not include any other information about the cause of the failure. For more information, see the about_Remote_Troubleshooting Help topic.
```

Rozwiązanie okazuje się dość proste, wystarczy wywołać 2 komendy PowerShella:
```powershell
Import-Module ServerManager     
Add-WindowsFeature WinRM-IIS-Ext
```
Które zainstalują WinRM IIS Extensions.