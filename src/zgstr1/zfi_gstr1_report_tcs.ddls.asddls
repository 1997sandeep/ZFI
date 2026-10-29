@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 report TCS amount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR1_REPORT_TCS 
  as select from ZFI_GSTR1_REPORT_TCS1 as a
{

key AccountingDocument,
LedgerGLLineItem,
CompanyCode,
FiscalYear,
DistributionChannel,
Division,
     cast( cast(tcs_amount as abap.fltp)
     / cast( 100 as abap.fltp) as abap.dec(30,2) ) as tcs_amount

}
