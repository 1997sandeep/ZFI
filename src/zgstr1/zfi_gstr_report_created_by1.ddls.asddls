@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR Report created by'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR_REPORT_CREATED_BY1
as select from I_JournalEntryItem

{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
  AccountingDocCreatedByUser,
  case
  when substring(AccountingDocCreatedByUser, 1, 2) = 'CB'
  then substring(AccountingDocCreatedByUser, 3, 10)
  else AccountingDocCreatedByUser
  end as created_by 
}

group by 
AccountingDocument,
CompanyCode,
FiscalYear,
AccountingDocCreatedByUser
