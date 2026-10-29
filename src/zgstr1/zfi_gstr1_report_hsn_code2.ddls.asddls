@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report HSN Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_HSN_CODE2
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
    b.IN_HSNOrSACCode as hsn_code,
      case
      when b.IN_HSNOrSACCode like '995%' then 'S'
      else 'G'
      end as HSNNature
    
    

} where a.AccountingDocumentType <> 'RV'

group by a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.AccountingDocumentType,
    b.IN_HSNOrSACCode
