@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Roundoff Amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_GSTR1_REPORT_ROUNFOFF_AMT 
as select from ZFI_GSTR1_REPORT_ROUNFOFF_AMT1
{
  key AccountingDocument,
  key CompanyCode,
  key FiscalYear,
  case
  when roundoff_amt < 0
  then cast(roundoff_amt * -1 as abap.dec(30,2))
  else cast(roundoff_amt as abap.dec(30,2))
  end as roundoff_amt
}
