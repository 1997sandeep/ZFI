@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report Invoice Value'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_INV_VAL 
 as select from ZFI_GSTR1_REPORT_TAX_VAL
{ 
   key AccountingDocument,
   CompanyCode,
   FiscalYear,
   LedgerGLLineItem,
   cast( coalesce(taxable_value,0) +
      coalesce(sgst_amount,0) +
      coalesce(cgst_amount,0) +
      coalesce(igst_amount,0) +
      coalesce(ugst_amount,0)
      as abap.dec(30,2)) as invoice_value
    
}
