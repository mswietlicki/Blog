Title: My expiriance with moving from ASP.NET 5 RC1 to ASP.NET Core RC2
Autor: Mateusz Świetlicki
CreateDate: 2016-05-18 17:08
Tags:	Blog
		EN
		.NET
        ASP.NET
        .NETCore

So lets start by cleaning our repositories git clean should be enouth.
```powershell
    git clean -dxf
```
Now install .NET Core SDK from <https://www.microsoft.com/net/core#windows> and restart all powershel consoles. After that I was able to run new dotnet command but it's still 2 days of work before everything will work again.

Basic help can be found in:

- <http://dotnet.github.io/docs/core-concepts/dnx-migration.html>
- <https://docs.efproject.net/en/latest/miscellaneous/rc1-rc2-upgrade.html>
- <https://docs.asp.net/en/latest/migration/rc1-to-rc2.html>

But this is what I did:

1. In all project.json files:
    - Replace "compilationOptions" with "buildOptions"
    - Replace "Microsoft.AspNet.IISPlatformHandler" with "Microsoft.AspNetCore.Server.IISIntegration"
    - Replate "Microsoft.AspNet." with "Microsoft.AspNetCore."
    - Replace "1.0.0-rc1-final" with "1.0.0-rc2-final"
    - Replace "6.0.0-rc1-final" with "1.0.0-rc2-final"
    - Remove "Microsoft.Extensions.Configuration.FileProviderExtensions"
    - Add "Microsoft.Extensions.Configuration.EnvironmentVariables": "1.0.0-rc2-final" if you need it
    - Replace "EntityFramework.Commands" with 
    ```
        "Microsoft.EntityFrameworkCore.Tools": {
            "type": "build",
            "version": "1.0.0-preview1-final"
        }
    ```
    - Remove command "ef": "EntityFramework.Commands"
    - Add tool Microsoft.EntityFrameworkCore.Tools:
    ```
    "tools": {
        "Microsoft.EntityFrameworkCore.Tools": {
            "version": "1.0.0-preview1-final",
            "imports": "portable-net452+win81"
        }
    },
    ```
    - Replace "EntityFramework.Core" with "Microsoft.EntityFrameworkCore": "1.0.0-rc2-final"
    - Replace "EntityFramework.MicrosoftSqlServer" with "Microsoft.EntityFrameworkCore.SqlServer": "1.0.0-rc2-final"
    - If you are using System.Web.Http add "Microsoft.AspNetCore.Mvc.WebApiCompatShim": "1.0.0-rc2-final"
    - If your framework is "dnx451" replcate it with "net461"
    - "xunit.runner.dnx" replace with "dotnet-test-xunit": "1.0.0-rc2-build10015"
    - command "test": "xunit.runner.dnx" replace with "testRunner": "xunit" but in root of JSON file.
    - Remove "exclude"
    - Remove "publishExclude"
    - Add "publishOptions":
    ```
        "publishOptions": {
            "include": [
                "wwwroot",
                "appsettings.json",
                "web.config"
            ]
        }
    ```
    - "tags", "projectUrl" and "licenseUrl" remove or add to "buildOptions"
    - Replace "version": "1.0.0-*" with "version": "1.0.0"
    - Consider adding "preserveCompilationContext": true to web app "buildOptions"
    
2. In whole solution:
    - Replace "using Microsoft.Data.Entity" with "using Microsoft.EntityFrameworkCore"
    - Replace "using Microsoft.AspNet." with "using Microsoft.AspNetCore."
3. In Sturtup.cs:
    - Replace "IServiceCollection.AddInstance" with "IServiceCollection.AddSingleton"
    - Remove "app.UseIISPlatformHandler();"
    - Replace "WebApplication.Run<Startup>(args);" with 
    ```c#
        public static void Main(string[] args)
        {
            var host = new WebHostBuilder()
            .UseKestrel()
            .UseContentRoot(Directory.GetCurrentDirectory())
            .UseIISIntegration()
            .UseStartup<Startup>()
            .Build();

            host.Run();
        }
    ```
    - .AddJsonFile("appsettings.json") replace with:
    ```c#
        .SetBasePath(env.ContentRootPath)
        .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
        .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
    ```
4. In program.cs:
    - Change "IApplicationEnvironment" to "ApplicationEnvironment"
5. In many places there is no more need for passing and using "ServiceCollection". You can remove it.
6. If you do not have it already it is a good idea to crate file nuget.config with:
```xml
    <?xml version="1.0" encoding="utf-8"?>
    <configuration>
    <packageRestore>
        <add key="enabled" value="True" />
        <add key="automatic" value="True" />
    </packageRestore>
    <packageSources>
        <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    </packageSources>
    </configuration>
```
7. Make sure that your .gitignore is correct. Good example can be found in <https://github.com/github/gitignore/blob/master/VisualStudio.gitignore> but I whould also add */wwwroot/lib at the end.
8. Move web.config from wwwroot to root of your project
9. For good manner delete all project.lock.json files.
10. If you have console apps using appsetting.json and "copyToOutput" to "buildOptions" in project.json:
```javascript
    "buildOptions": {
        "emitEntryPoint": true,
        "copyToOutput": [
            "appsettings.json"
        ]
    },
```
11. Change all projects that use EF and are Libraries to .NET Core App by adding static void Main() and buildOption emitEntryPoint.
```javascript
  "buildOptions": {
    "emitEntryPoint": true
  },
```
12. If it posible remove all your existing EF migrations, drop your db and create them from scrach. 
13. If you are using xunit you probably need to add "C:\Program Files\dotnet\sdk\1.0.0-preview1-002702\runtimes\win-x86\native" to you PATH env properties.

Now you should be able to run:
```powershell
    dotnet restore
    dotnet build
    dotnet test
    dotnet run
```

Common errors
-------------

Error: 
    "Microsoft.DiaSymReader.Native.x86.dll" Not found.
    
Soluction: 
    Try adding "C:\Program Files\dotnet\sdk\1.0.0-preview1-002702\runtimes\win-x86\native" to you PATH env properties.



Usefull links
-------------
<https://blogs.msdn.microsoft.com/dotnet/2016/05/16/announcing-net-core-rc2/>
<https://github.com/dotnet/cli/issues/3069>
<https://docs.efproject.net/en/latest/cli/dotnet.html>
<https://docs.asp.net/en/latest/fundamentals/configuration.html>
<https://docs.efproject.net/en/latest/modeling/index.html>
<https://blogs.msdn.microsoft.com/dotnet/2016/05/16/announcing-entity-framework-core-rc2/>
<http://dotnet.github.io/docs/core-concepts/dnx-migration.html>
<https://docs.asp.net/en/latest/testing/unit-testing.html>