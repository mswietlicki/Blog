Title: Dynamiczne dodawanie warunków do IQueryable
Autor: Mateusz Świetlicki
CreateDate: 2012-02-11 10:49
Tags: 	Blog
		.NET
		Triki

Mieliście kiedyś potrzebę stworzenia generycznej metody która enkapsulowałaby warunek LINQ i która można by użyć w zapytaniu np. do EntityFramework bez utraty IQueryable na IEnumarable?

Ja tak. Na w zapytaniu:

```c#
var sessionId = getUserSession();
var sds = DB.UserDetails.Where(d => d.SessionId == sessionId)
            .Where(d => d.UserId == competencyScore.EnityId)
            .Select(d => d.OfficeUnit).First();
```

Sprawdzenie czy detale są z danej sesji wymaga dodatkowej zmiennej i warunku, a biorąc pod uwagę, że taki sam warunek przynależności do sesji używam w wielu innych zapytaniach przydało by się go opakować w funkcję, tak aby powstało coś takiego:

```c#
var units = DB.UserDetails.InUserSession()
				.Where(d => d.UserId == competencyScore.EnityId)
 				.Select(d => d.OfficeUnit)
```

Jest to bardziej skomplikowane niż się wydaje ponieważ funkcja powinna być generyczna i najlepiej by rozszerzała IQuerable.

Ostatecznie udało mi się rozwiązać problem używając klasy Expression:

```c#
public static IQueryable InUserSession(this IQueryable queryable)
{
    var sessionId = getUserSession();
    return queryable.AddEqualityCondition("SessionId", sessionId);
}
 
public static IQueryable AddEqualityCondition(this IQueryable queryable, string propertyName, V propertyValue)
{
    ParameterExpression pe = Expression.Parameter(typeof(T), "p");
 
    IQueryable x = queryable.Where(
        Expression.Lambda>(
            Expression.Equal(Expression.Property(pe, typeof (T).GetProperty(propertyName)),
                             Expression.Constant(propertyValue, typeof (V)), false,
                             typeof (T).GetMethod("op_Equality")), new ParameterExpression[] {pe}));
    return (x);
}
```

Uwaga: AddEqualityCondition nie potrafi porównać typu prostego i jego Nullable więc wracajcie na to uwagę.