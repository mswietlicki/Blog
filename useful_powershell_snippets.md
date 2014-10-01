Title: Useful Powershell snippets
Autor: Mateusz Świetlicki
CreateDate: 2014-09-11 09:50
Tags:	Blog
		EN
		PowerShell

List all application pools (AppPools)
-------------------------------------

```ps
	Get-Childitem IIS:\AppPools\
```

List machine environment path record
--------------------------------------

```ps
	[Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine).Split(";")
```

Add new machine environment path record
--------------------------------------

```ps
	function Add-EnvPath
	{
	    param($newPath)

	    if([System.String]::IsNullOrEmpty($newPath)){
	        Write-Error "Path must not be null!"
	        return -1
	    }
	    
	    if(![System.IO.Directory]::Exists($newPath)){
	        Write-Error "Path does not exist!"
	        return -1
	    }

	    $path = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
		$path += ";" + $newPath

	    [Environment]::SetEnvironmentVariable("Path", $path, [System.EnvironmentVariableTarget]::Machine)
	}
```

Get installed .NET frameworks versions
--------------------------------------

```ps
	function Get-NetVersions {
	    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
	    Get-ItemProperty -name Version -EA 0 |
	    Where { $_.PSChildName -match '^(?!S)\p{L}'} |
	    Select PSChildName, Version
	}
```

Thanks to Jaykul. [](http://stackoverflow.com/questions/3487265/powershell-to-return-versions-of-net-framework-on-a-machine)