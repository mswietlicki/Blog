Initialize-ASPersistenceSqlDatabase –Database test_de_appfabric_persistence –Server .\SQLEXPRESS –Readers AS_Observers –Users “BUILTIN\IIS_IUSRS” –Admins AS_Administrators

Initialize-ASMonitoringSqlDatabase –Database test_de_appfabric_monitoring –Server .\SQLEXPRESS –Readers AS_Observers –Writers AS_Administrators –Admins AS_Administrators

msbuild ExpertiseCheck.DE.build /t:migrate /p:Platform=AnyCPU

System.AggregateException: One or more errors occurred. ---> System.ServiceModel.FaultException`1[System.ServiceModel.ExceptionDetail]: Unable to load DLL 'pdf2txt.dll': The specified module could not be found. (Exception from HRESULT: 0x8007007E)

C:\mailbox\ExpertiseCheck

TeileProfi

SELECT m.Status, v.VorgangAbgeschlossen, * FROM Vorgang as v JOIN tMessageIn as m ON v.MessageEID = m.MessageEID

Debugging/Use Managed Compatibility Mode

Lync

Sign-in address:
	m.swietlicki@cyfrowypolsat.com
Login:
	ce_warszwawa\mswietlicki
Pass:
	{domain password}


Cannot find connection string for connection name 'ApplicationServerWorkflowInstanceStoreConnectionString'