@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report RoundOff Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_ROUNFOFF_AMT1
as select from I_JournalEntryItem
{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
  sum(cast(AmountInTransactionCurrency as abap.dec(30,2))) as roundoff_amt
}where 
     FinancialAccountType = 'S'
    and Ledger = '0L'
    and ControllingBusTransacType = 'COIN'
    and GLAccount = '0050300106'

group by
AccountingDocument,
CompanyCode,
FiscalYear
