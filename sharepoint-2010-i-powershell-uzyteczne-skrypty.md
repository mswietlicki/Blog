Title: SharePoint 2010 i PowerShell użyteczne skrypty
Autor: Mateusz Świetlicki
CreateDate: 2010-08-15 17:54
Tags: 	Blog
		PL
		PowerShell
		SharePoint

W nowym SharePoint 2010 sryptowe zarządzanie zostało przeniesione z STSADM 
do coraz popularniejszego PowerShella.
W tym artykulę napiszę postaram się zamieścić podstatowe użyteczne skrypty dla developera SP2010.
By zacząć pracę z SharePoint 2010 w consoli PowerShell należy uruchomić wersję x64 konsoli i zainportować polecenia:

```powershell
Add-PSSnapin Microsoft.SharePoint.PowerShell
```

Teraz można już przetestować działanie enumerując kontrolki:

```powershell
Get-SPFarm
```

Oczywiście jeżeli nie chcesz wpisywać tego za każdym razem gdy chcesz się dostać do SP możesz dodać powyższą komendę do pliku (który domyślnie nie istnieje):

```powershell
<user_documents>/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
```

Przykłądowy skrypt wysukujący content typów danej listy i tworzący elementy na innej liście
```powershell
$12HivesDir = "${env:CommonProgramFiles}\Microsoft Shared\web server extensions\14\" 
[System.Reflection.Assembly]::LoadFrom("$12HivesDir\ISAPI\Microsoft.SharePoint.dll")
  
$devSite = New-Object -TypeName "Microsoft.SharePoint.SPSite" -ArgumentList "http://192.168.0.201/Repozytorium"; 
$devWeb = $devSite.OpenWeb();
  
$zadania = $devweb.GetList(“http://192.168.0.201/Repozytorium/Lists/Zadania")</a>
  
$types = @() 
$dtypes = @() 
foreach($ctype in $zadania.ContentTypes) 
{ 
	$types += $ctype.name 
}
  
$opisy = $devweb.GetList(http://192.168.0.201/Repozytorium/Lists/Opisy%20wiadomoci)
  
foreach($ctype in $opisy.items) 
{ 
	$dtypes += $ctype.name 
}
  
foreach($ctype in $types) 
{ 
	if($dtypes -notcontains $ctype) 
	{ 
		Write-Host "Dodaje element: ", $ctype
		$item = $opisy.AddItem() 
		$item.item("Typ zadania") = $ctype
		$item.Update() 
	} 
}
```