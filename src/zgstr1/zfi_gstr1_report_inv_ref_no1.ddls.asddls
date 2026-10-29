@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report om infra Invoice Reference No.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_INV_REF_NO1 
as select distinct from I_JournalEntryItem as a
left outer join I_BillingDocumentBasic as b
 on a.ReferenceDocument = b.BillingDocument
{
     key a.AccountingDocument,
     a.CompanyCode,
     a.FiscalYear,
     a.AccountingDocumentType,
     case 
     when a.AccountingDocumentType = 'DR' or
          a.AccountingDocumentType = 'DG'
     then a.DocumentItemText
     else b.YY1_InvoiceNumber_BDH
     end as InvoiceNo,
     a.LedgerGLLineItem
}
where a.Ledger = '0L'
group by a.AccountingDocument,
     a.CompanyCode,
     a.FiscalYear,
     a.AccountingDocumentType,
     a.DocumentItemText,
     b.YY1_InvoiceNumber_BDH,
    a.LedgerGLLineItem
     
