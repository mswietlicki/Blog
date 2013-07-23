Title: Jak zmienić tło ekranu logowania
Autor: Mateusz Świetlicki
CreateDate: 2010-04-11 00:41
Tags:	Blog
		PL
		Windows

Windows 7 tak samo jak Vista umożliwia twórcom OEM zmianę tła okna logowania do Windowsa.

Aby je zmienić należy edytować wpis w rejestrze:
```
HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Background na "1"
```

Następnie utworzyć plik `%windir%\System32\oobe\info\backgrounds\backgroundDefault.jpg` (plik nie może być większy niż 256kB)

Lub skorzystać z narzędzia TweaksLogon