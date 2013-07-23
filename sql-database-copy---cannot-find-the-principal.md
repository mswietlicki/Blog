Title: SQL Database Copy - Cannot find the principal
Autor: Mateusz Świetlicki
CreateDate: 2012-05-24 21:21
Tags: 	Blog
		PL
		SQL
		Error

Napotkałem dziś ciekawy problem podczas kopiowania bazy SQL z jednego serwera (w domenie) do drugiego (poza domeną).

Okazało się, że mimo iż nie kazałem mu kopiować uprawnień SQL zgłaszał błąd:

*Cannot find the principal '3W\mswietlicki', because it does not exist or you do not have permission.*

Okazało się, że '*3W\mswietlicki*' niechcący był OWNERem przenoszonej bazy danych.

Aby to naprawić musiałem użyć:

```sql
EXEC sp_changedbowner 'sa'
```
By zmienić ownera na niedomenowego ‘sa’.