Title: Problem z reinstalacją aplikacji ClickOnce
Autor: Mateusz Świetlicki
CreateDate: 2011-04-11 15:02
Tags: 	Blog
		PL
		ClickOnce
		IT

![ClickOnce autoupdate](http://bloggingabout.net/blogs/dennis/WindowsLiveWriter/ManualcheckforupdateswithClickOnce_A5E8/clickonce_autoupdate_3.gif)

Czyszczenie cache'a w wypadku problemu z już zainstalowaną aplikacją:

```powershell
rundll32 dfshim CleanOnlineAppCache
```