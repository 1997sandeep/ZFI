@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for gstr1 round of'
@Metadata.ignorePropagatedAnnotations: true
define view entity zfi_gstr1_round_of_cds as select
from I_JournalEntryItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
        cast(sum(AmountInTransactionCurrency) as abap.dec(13,2)) as round_off_amt
}
where
      ( GLAccount = '0040200059'
    or GLAccount = '0050200028'
    or GLAccount = '0050300106'
    or GLAccount = '0050500054')
    and Ledger = '0L'
group by
    AccountingDocument,
    CompanyCode,
    FiscalYear
