Title: Fody - My first impression
Autor: Mateusz Świetlicki
CreateDate: 2014-06-20 22:14
Tags:	Blog
		PL
		.NET

Today I spend my evening with Fody an open source PostSharp alternative. [Fody](https://github.com/Fody/Fody)

Personaly I think that this type of library is must have for every project, specially ones using WPF and MVVM but I won't agree with every available Fody plugin.

For example using Fielder.Fody you can change auto-propety to public field and it will still be seen as property:
```c#
public class Person
{
	public string FirstName { get; set; }
	public string LastName { get; set; }
}
```
equals

```c#
public class Person
{
	public string FirstName;
	public string LastName;
}
```
And you don't even need to add any attributes! 
I thing that this plugin is dangerous and to much like magic. Using it will only obscure your code and make it less readable. 

Nevertheless many other plugin are extremely useful! E.g.:

Antor.Fody:
```c#
	[LogToDebugOnException]
	private int Work(){
		...

		LogTo.Trace("Some event");
	}
```

Commander.Fody:
```c#
	[OnCommandCanExecute("SubmitCommand")]
    public bool CanSubmit()
    {
        ... 
    }
    [OnCommand("SubmitCommand")]
    public void OnSubmit(){
        ...
    }
```

Equals.Fody:
```c#
	[Equals]
	public class Point
	{
	    public int X { get; set; }

	    public int Y { get; set; }
	}

	[Fact]
	public void PointEquality
	{
		var a = new Point { X = 4, Y = 5 };
		var b = new Point { X = 4, Y = 5 };

		Assert.IsTrue(a == b);
	}
```

PropertyChanged.Fody:
```c#
	[ImplementPropertyChanged]
	public class Person 
	{        
	    public string GivenNames { get; set; }
	    public string FamilyName { get; set; }

	    public string FullName
	    {
	        get
	        {
	            return string.Format("{0} {1}", GivenNames, FamilyName);
	        }
	    }
	}
```

NullGuard.Fody:
```c#
	[assembly: NullGuard(ValidationFlags.All)]
	...

	public void SomeMethod(string arg)
    {
        // throws ArgumentNullException if arg is null.
    }
```

ToString.Fody
```c#
	[ToString]
	public class Point
	{
	    public int X { get; set; }

	    public int Y { get; set; }
	}

	...

	Console.WriteLine(new Point { X = 4, Y = 5 }); //Returns: {T: "Point", X: 4, Y: 5}
```

In summary try it and love it. Your life will be much easier. :)