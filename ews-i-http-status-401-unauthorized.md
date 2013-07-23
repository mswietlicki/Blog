Title: EWS i HTTP status 401: Unauthorized
Autor: Mateusz Świetlicki
CreateDate: 2011-07-8 15:39
Tags: 	Blog
		PL
		.NET
		WCF

Cześć,

Natknąłem się ostatnio na problem podłączenia się do Exchange 2010 SP1, wykorzystując EWS (Exchange Web Service)

Podczas próby połączenia się do usługi serwer zwracał błąd: “*The request failed with HTTP status 401: Unauthorized.*” lub cos o niedostępności Active Directory. 
Problem dziwny ponieważ dane logowania na pewno podawałem poprawne.

Mój kod wyglądał w ten sposób:

```c#
ExchangeService service = new ExchangeService(ExchangeVersion.Exchange2010_SP1);
service.Credentials = new WebCredentials("temp1", "temp", "domena");
service.TraceEnabled = true;
service.Url = new Uri("http://192.168.0.205/EWS/Exchange.asmx");
 
ListAppointments(service);
```

Po przejrzeniu wielu niepomocnych wątków w Internecie spróbowałem przejrzeć się samej klasie ExchangeService gdzie znalazłem:

```c#
service.PreAuthenticate = true;
```

Co natychmiastowo rozwiązało mój problem.

Mam nadzieję, że wam też rozwiązanie pomoże.