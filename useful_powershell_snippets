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