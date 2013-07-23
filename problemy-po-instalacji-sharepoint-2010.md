Title: Problemy po instalacji SharePoint 2010
Autor: Mateusz Świetlicki
CreateDate: 2010-08-2 12:44
Tags: 	Blog
		PL
		SharePoint
		Error

Pracując ostatnio w małej firmie programistycznej natkneliśmy się na pożny problem podczas naszych pierszych kroków z SharePoint 2010.

Po instalacji SharePointFundation wszystko zdawało się działać dobrze dla osoby która go zainstalowała, ale gdy ktoś próbował dostać się z zewnątrz czy nawet później z serwera nagle wszystko działało dziwnie.

Otóż:

- listy działały tak jakby tylko na stronie głównej
- panele administracyjne dodanych fitryn wyrzucały błędy braku pliku
- system nie widział użytkowników domeny

Męczyliśmi się z tym kilka dobrych godzin myśląc że to błąd instalacji SP czy specyfikacji serwera. Na koniec jednak okazało się że błąd jest banalny.

**Błędy tego typu występują gdy użytkownik próbuje dostać się do serwera podając adres który nie jest skonfigurowany w ustawieniach mapowania alternatywnego.**

Jeżeli np. mapowanie jest skonfigurowane na <http://mojserwer> to dostanie się z <http://localhost> czy <http://192.168.0.1> mimo że teoretycznie poprawne powoduje błędy linków i tym samym w.w. problemy.

**Należy więc dodać wszystkie możliwe mapowania do konfiguracji w paneli administracyjnym.**