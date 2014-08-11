Title: Manage NuGet while using submodules / sub-solutions
Autor: Mateusz Świetlicki
CreateDate: 2014-08-11 14:50
Tags:	Blog
		EN
		.NET
		PowerShell

Nuget is great package manager for .NET projects but it is not perfect in some advance usages.

For example if you are using git submodules in your solution, projects from submodule can have different package repository path than the main projects.

If you have solution structure like:

	C:\Code\Foo\Foo.sln
	C:\Code\Foo\Foo\Foo.csproj
	C:\Code\Foo\Lib\Bar\Bar.sln
	C:\Code\Foo\Lib\Bar\Bar\Bar.csproj

and if Foo.sln contains Bar.csproj and Foo.csproj depends on Bar.csproj and you would like to build Bar.csproj while building Foo.sln you will have problem with nuget packages!

Foo.sln will look for nuget packages in:
	
	C:\Code\Foo\packages

But Bar.sln will look for nuget packages in:

	C:\Code\Foo\Lib\Bar\packages

And Bar.csproj will have reference to:

	<Reference Include="log4net, Version=1.2.10.0, Culture=neutral, PublicKeyToken=1b44e1d426115821, processorArchitecture=MSIL">
      <SpecificVersion>False</SpecificVersion>
      <HintPath>..\..\packages\log4net.1.2.10\lib\2.0\log4net.dll</HintPath>
    </Reference>

Which translates to:

	C:\Code\Foo\Lib\Bar\packages\log4net.1.2.10\lib\2.0\log4net.dll

One way to fix this problem is to use Nuget Restore but not the one in Visual Studio. The one in visual studio will try to point all projects to C:\Code\Foo\packages which is not that we want.

But if you add NuGet.exe to solution and create PowerShell script Restore.ps1

```ps
	$slns = Get-ChildItem -r | ? Extension -eq ".sln" | % FullName
    $slns | % { .\.nuget\NuGet.exe restore $_ }
```

And run it at least once pre-build you will be sure all the nuget packages are where they suppose to be.