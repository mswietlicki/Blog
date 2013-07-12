Title: Jak uruchomić ASP.NET 4.0 po Windows 2003 IIS6
Autor: Mateusz Świetlicki
CreateDate: 2011-09-15 13:05
Tags: 	Blog
		.NET
		ASP.NET
		Error
		IIS
		Windows
		Windows Server

Jak uruchomić ASP.NET 4.0 po Windows 2003 IIS6
===========

Jeśli otrzymujecie błąd:

```xml
<compilation debug="true" targetframework="4.0">     
    <assemblies>      
         <add assembly="System.Data.Entity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"></add>
	</assemblies>      
</compilation>
```
``` 
fails with
Exception information:  
Exception type: ConfigurationErrorsException Exception message:
Unrecognized attribute 'targetFramework'. 
Note that attribute names are case-sensitive.
```

To powinieneś zainstalować .NET 4.0 framework oraz uruchomić na serwerze:

```powershell
C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319>aspnet_regiis -i
```

Jako ciekawostkę dodam, że ASP.NET 4.0 można wyinstalować komendą:

```powershell
C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319>aspnet_regiis -u
```
