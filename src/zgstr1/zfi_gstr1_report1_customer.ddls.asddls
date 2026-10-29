@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT1_CUSTOMER 
as select from I_JournalEntryItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
    Customer
} where Customer <> ' '

group by AccountingDocument,
CompanyCode,
FiscalYear,
Customer
