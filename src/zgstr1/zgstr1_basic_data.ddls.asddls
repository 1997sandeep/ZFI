@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZGSTR1_BASIC_DATA
  as select from I_JournalEntry as a
//  left outer join       I_OperationalAcctgDocItem      as b    on  a.CompanyCode           = b.CompanyCode
//                                                                  and a.FiscalYear            = b.FiscalYear
//                                                                  and a.AccountingDocument    = b.AccountingDocument
//                                                                  and b.FinancialAccountType = 'D'
//  left outer join       I_BillingDocumentItem         as c    on  b.BillingDocument = c.BillingDocument
//                                                                  and b.BillingDocument is not initial
                                                                  
{
  key a.AccountingDocument,
  key a.FiscalYear,
  key a.CompanyCode,
      a.AccountingDocumentType,
      a.DocumentDate,
      a.PostingDate,
      a.ReversalReferenceDocument
//      b.BillingDocument,
//      c.Product
}
where
     a.AccountingDocumentType = 'DR'
  or a.AccountingDocumentType = 'RV'
  or a.AccountingDocumentType = 'DG'
group by
  a.AccountingDocument,
  a.FiscalYear,
  a.CompanyCode,
  a.AccountingDocumentType,
  a.DocumentDate,
  a.PostingDate,
    a.ReversalReferenceDocument
//    b.BillingDocument,
//    c.Product
