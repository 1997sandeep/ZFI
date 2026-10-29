@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Sales Invoice No'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR_REPORT_SALES_INVNO 
as select from I_AccountingDocumentJournal(P_Language : 'E') as a
{
 key a.AccountingDocument,
 key a.CompanyCode,
 key a.FiscalYear,
     a.DocumentReferenceID
}
where a.Ledger = '0L'
and a.DocumentReferenceID <> ''
