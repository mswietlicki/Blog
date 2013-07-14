Title: Create a .dbml descriptor file for the Database
Autor: Mateusz Świetlicki
CreateDate: 2010-08-15 17:54
Tags: 	Blog
		PowerShell
		Nuget
		Chocolatey
		Windows

To do this you need to use the `SqlMetal.exe` tool. Just type the following into the Visual Studio 2008 Command Prompt:
```
SqlMetal.exe MyDatabase.sdf /dbml:MyDatabase.dbml
```
By default, the `SqlMetal.exe` is located at `drive:\Progream Files\Microsoft SDKs\Windows\vn.nn\bin`