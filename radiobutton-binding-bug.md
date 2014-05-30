Title: RadioButton binding bug
Autor: Mateusz Świetlicki
CreateDate: 2013-07-17 18:50
Tags:	Blog
		PL
		Bug
		XAML
		WPF
		.NET

W .NET 3.5 istnieje bug powiązany z bindingiem właściwości **IsChecked**. Powiązana właściwość ViewModelu nie zmienia się automatycznie na False. 

Problem został naprawiony w .NET 4.0 ale jeżeli jesteś zmuszeni to korzystania z 3.5 musisz użyć obejścia polegającego na ręcznym resetowaniu właściwości na False gdy jedno z nich zostanie ustawione na True. 

UWAGA: Zmiana wartości na False musi wywołać zdarzenia OnPropertyChanged inaczej trik nie zadziała.

```xml
<StackPanel>
    <RadioButton GroupName="Rozmowa" Content="Rozmowa z klientem" IsChecked="{Binding IsTalkWithClient}" />
    <RadioButton GroupName="Rozmowa" Content="Rozmowa z osobą decyzyjną" IsChecked="{Binding IsTalkWithDecisionPerson}"/>
</StackPanel>
```

```c#
public bool IsTalkWithClient
{
    get { return _isTalkWithClient; }
    set
    {
        _isTalkWithClient = value;
        OnPropertyChanged(() => IsTalkWithClient);

        if (IsTalkWithClient) IsTalkWithDecisionPerson = false;
    }
}

public bool IsTalkWithDecisionPerson
{
    get { return _isTalkWithDecisionPerson; }
    set
    {
        _isTalkWithDecisionPerson = value;
        OnPropertyChanged(() => IsTalkWithDecisionPerson);

        if (IsTalkWithDecisionPerson) IsTalkWithClient = false;
    }
}
```

