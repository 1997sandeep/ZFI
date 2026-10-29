@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report Tax Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT1_TAX_CODE 
as select from I_JournalEntryItem as a
{
  key a.AccountingDocument,
  a.CompanyCode,
  a.FiscalYear,
  a.LedgerGLLineItem,
  a.AccountingDocumentItem,
  case 
  when a.IsReversed = 'X'
  then 'Yes'
  else 'No'
  end as DocumentIsRevered,
  
  case 
  when a.IsReversal = 'X'
  then 'Yes'
  else 'No'
  end as ReveredDocument,
  
  a.TaxCode,
  a.FinancialAccountType,
  a.OffsettingAccount,
  a.GLAccount,
  a.AccountingDocumentType,
  a.ReferenceDocument,
  a.Customer,
  a.ProfitCenter,
  case
  when a.AmountInTransactionCurrency < 0
  then cast(a.AmountInTransactionCurrency * -1 as abap.dec(30,3))
  else cast(a.AmountInTransactionCurrency as abap.dec(30,3))
  end as taxable_value,
  cast(a.Quantity as abap.dec(15,2)) as quantity,
  a.BaseUnit,
  a.AccountingDocCreatedByUser
}where
     a.FinancialAccountType = 'S'
    and a.Ledger = '0L'
    and a.ControllingBusTransacType = 'COIN'
    and a.GLAccount <> '0050300106'


