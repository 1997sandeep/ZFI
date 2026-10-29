@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report TCS Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_TCS1 
as select from ZFI_GSTR1_REPORT_TAX_VAL as a
 left outer join I_BillingDocument as b
   on a.AccountingDocument = b.AccountingDocument
  and a.CompanyCode = b.CompanyCode
  and a.FiscalYear = b.FiscalYear
{
  key a.AccountingDocument,
    a.LedgerGLLineItem,
    a.CompanyCode,
    a.FiscalYear,
    b.DistributionChannel,
    b.Division,
    
    case
    when a.taxable_value is not null and 
         a.igst_amount is not null
    then a.taxable_value + a.igst_amount
    
    when a.taxable_value is not null and 
         a.cgst_amount is not null and
         a.sgst_amount is not null
    then a.taxable_value + a.sgst_amount + a.cgst_amount
    
    when a.taxable_value is not null and 
         a.ugst_amount is not null
    then a.taxable_value + a.ugst_amount
    end as tcs_amount

} where b.DistributionChannel = '30'
    and b.Division = '31'
