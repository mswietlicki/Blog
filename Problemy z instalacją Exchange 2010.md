Title: Problemy z instalacją Exchange 2010
Autor: Mateusz Świetlicki
CreateDate: 2011-04-11 12:40
Tags: 	Blog
		Windows
		IT
		Exchange

Problemy z instalacją Exchange 2010
===========

Cześć,

Opisze dzisiaj serię problemów które miałem z instalacją Microsoft Exchange 2010 SP1 pod Windows Server 2008 R2 SP1 i migrację danych z Exchange 2003 działającym na Windows Server 2003 R2 SP2 PL który jest również kontrolerem domeny poziomu Windows Server 2003 Native.

OK, oto lista błędów  w chronologicznej kolejności:

1. "Active Directory does not exist”. OK, upewniłem się że DNS jest poprawnie ustawiony na serwer AD, a nie na internet, oczywiście był bo było to konieczne do dodatnia serwera do domeny. Następnie po chwili googlowania with bing pomógł msdn http://technet.microsoft.com/en-us/library/bb125224.aspx i komenda “ServerManagerCmd -i RSAT-ADDS” uruchomiona na komputerze pod Exchange 2010.
2. “The schema master is not running Windows Server 2003 Service Pack 1”. Tutaj okazało się, że problemem jest polska wersja windowsa. Należało zmienić ustawienia na serwerze domeny przy użyciu ADSI Edit (AdsiEdit.msc). Okazało się że kontroler domeny przedstawiał swój operationSystemServicePack jako “Dodatek Service Pack 2” zamiast “Service Pack 2”. 

![](http://mateusz.swietlicki.net/image.axd?picture=image_1.png)

3. Dalej jeszcze gorzej. Tym razem “Could not find any Domain Controller in domain 3w.local.”. Póki co uruchomiłem “PS D:\> .\Setup.com /PrepareAD” gdzie d: jest dyskiem instalacyjnym exchange 2010 i czekam dobrą godzinę na zakończenie. OK, Super zakończyło się bez błędu, uruchomiłem jeszcze “PS D:\> .\setup.com /PrepareDomain” dla pewności i wystartowałem okienkową instalację.
 
![](http://mateusz.swietlicki.net/image.axd?picture=image_3.png)

![](http://mateusz.swietlicki.net/image.axd?picture=image_4.png)

4. Hmm, znowu “The schema master is not running Windows Server 2003 Service Pack 1” powtórzę stare rozwiązanie z AdsiEdit.msc…
5. Super, jeszcze tylko Warningi:
	1. ”This computer requires the Microsoft Office 2010 Filter Packs.” Szybki skok na <http://go.microsoft.com/fwlink/?LinkID=191548> i po problemie.
	2. ”If Microsoft Outlook 2003 is in use, you should replicate the free/busy folder on this server to every other free/busy server in the organization. This step should be performed once Setup completes.” ale to później.
6. 27min i instalacja zakończyła się sukcesem. Updates i Restart.
7. Przenoszenie danych: [http://www.youtube.com/watch?feature=player_embedded&v=-NKkas5N4kY](http://www.youtube.com/watch?feature=player_embedded&v=-NKkas5N4kY)
8. Problem z certyfikatem SSL. Jeszcze nie rozwiązany… 
