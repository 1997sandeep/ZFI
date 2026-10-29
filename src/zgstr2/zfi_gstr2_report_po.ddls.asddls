@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT_PO 
as select from I_JournalEntryItem
{
    key AccountingDocument,
    CompanyCode,
    FiscalYear,
    PurchasingDocument
    
} where PurchasingDocument <> ' '

group by AccountingDocument,
    CompanyCode,
    FiscalYear,
    PurchasingDocument
