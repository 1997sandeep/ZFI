@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report HSN Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT_HSN_CODE2 
 as select from I_JournalEntryItem as a
 left outer join I_OperationalAcctgDocItem as b
   on a.AccountingDocument = b.AccountingDocument
  and a.AccountingDocumentItem   = b.AccountingDocumentItem
 
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.AccountingDocumentType,
    b.IN_HSNOrSACCode as hsn_code
    

} where a.AccountingDocumentType <> 'RE'
    and b.IN_HSNOrSACCode <> ' '

group by a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.AccountingDocumentType,
    b.IN_HSNOrSACCode
