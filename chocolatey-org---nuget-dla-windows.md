Title: chocolatey.org – Nuget dla Windows
Autor: Mateusz Świetlicki
CreateDate: 2012-06-09 15:56
Tags: 	Blog
		PowerShell
		Nuget
		Chocolatey
		Windows

Natknąłem się ostatnio na bardzo fajne narzędzie: <http://chocolatey.org>

Jest to konsolowe narzędzie pozwalające automatycznie instalować i aktualizować programy takie jak 7zip, notepad++, vlc, chrome itd…

Ja stworzyłem sobie prostym pliczek PowerShella który automatycznie zainstaluje prawie wszystkie moje ulubione aplikacje z ciągu kilku minut.

```powershell
powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))"
cinst chocolatey
cinst 7zip
cinst notepadplusplus
cinst filezilla
cinst ChocolateyGUI
cinst vlc
cinst putty
cinst 7zip.commandline
cinst paint.net
cinst webpicommandline
cinst linqpad4
cinst tortoisesvn
cinst foobar2000
cinst ilspy
cinst PowerGUI
cinst NugetPackageExplorer
cinst synergy
cinst WindowsLiveInstaller
cinst procmon
cinst clojure.clr
cinst procmon
```

Dla pewności uruchom jako Administrator.