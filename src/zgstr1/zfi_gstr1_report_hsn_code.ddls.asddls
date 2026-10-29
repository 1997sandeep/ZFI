@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report HSN Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_HSN_CODE 
 as select from ZFI_GSTR1_REPORT_HSN_CODE1
{
    key AccountingDocument,
    CompanyCode,
    FiscalYear,
    LedgerGLLineItem,
    hsn_code,
    HSNNature
} union 
select from ZFI_GSTR1_REPORT_HSN_CODE2
{
  key AccountingDocument,
  CompanyCode,
  FiscalYear,
  LedgerGLLineItem,
  hsn_code,
  HSNNature
}
