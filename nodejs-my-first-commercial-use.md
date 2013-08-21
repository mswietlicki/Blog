Title: FTL: Node.js my first commercial use
Autor: Mateusz Świetlicki
CreateDate: 2013-08-21 12:39
Tags: 	Blog
		EN
		Node.js
		nodejs

Last week I find myself in need to write quite big SQL script that would migrate data from one db to second slightly different db and also create triggers for persistent continues migration. Instead of doing this by hand I decided to write simple node.js console program that will connect to MSSQL db get required date and output finished SQL script.

![Node.js](/files/nodejs-dark.png)

First of course you need to have install node.js on your machine. This part is easy. Just go to [http://nodejs.org](http://nodejs.org) and download windows installer.


Secondly you need some kind of text editor or IDE. I experimented with [SublimeText 2](http://www.sublimetext.com), [Light Table](http://www.lighttable.com) and even [Vim](http://www.vim.org) but eventually I came but to Visual Studio 2012 with [Node.js plugin](https://github.com/dtretyakov/node-tools). 
Vim and SublimeText are fast and powerfull text editors but lack of refactoring, lack of real-time code check and configuration needed to integrate with node.js was to much for me.
Light Table is very promising but not yet fully ready for day to day use. (v. 0.4.0)


Thirdly you need node.js module for MSSQL connection. There is official Microsoft package [msnodesql-0.2.1-v0.6](http://www.microsoft.com/en-us/download/details.aspx?id=29995) but it is very hard to install correctly so I settle for [npm install mssql](https://npmjs.org/package/mssql). There is however a but in mssql module that makes it unable to connect to sql server with instance (e.g. "server01\instace01"), fortunately I don't need this function.

While installing node modules remember that Visual Studio Node Package Manager saves module in project directory and don't share them with external node app. 

Also you can't install modules from Command Prompt or PowerShell while it's in Administrator mode. I mean you can but it will install them in %WINDIR%\System32 for some reason and node.exe won't see them.

Also npm install -g ... is use for module to be accessible from cmd. Not globally or something.


I can't really show you the code but I will give you couple tips that I find out hard way:

1.
If function calls async function you need to specify callback. There is no other simple way to wait for result.

2.
```js
	process.stdout.write(text); 
	or 
	console.log(text); 
```
is __sync__ if you print to console but __async__ if you print to pipe (file) so don't do process.exit(0); directly after. 
```js
	process.stdout.addListener("drain", function () { 
		process.exit(0); 
	}); 
```
will wait for stream to print.

3.
```js
	columns.map(function (c) { return c.name; }).join(', '); 
```
usefull for strings concat.

4.
JavaScript have 'for' loop async bug so you have to pass item as function parameter;

```js
    for (var i in tables) {
        var table = tables[i];

        doSomethingAsync(table, function (table, columns) {
            ...
        });
    }
```



