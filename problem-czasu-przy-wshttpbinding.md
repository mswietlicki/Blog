Title: Problem czasu przy wsHttpBinding
Autor: Mateusz Świetlicki
CreateDate: 2010-04-15 00:41
Tags: 	Blog
		.NET
		WCF

Inner Exception: An unsecured or incorrectly secured fault was received from the other party. See the inner FaultException for the fault code and detail.

Problem w moim przypadku wystąpił przy próbie połączenia proxy z usługą WCF korzystającej z wsHttpBinding, ponieważ godzina serwera różniła się o około 10min od godziny klienta. Co ciekawe to serwer miał zły czas.