spCRMRaportDoGeneracjiZgloszenZapisanychPrzezKonsultanta

registry.ForRequestedType<ICommentService>()
    .TheDefaultIsConcreteType<CommentService>()
    .EnrichWith((ioc, original) => new CommentAuditService(original, 
                                   ioc.GetInstance<AuditService>()));

http://stackoverflow.com/questions/1443464/structuremap-and-the-decorator-pattern