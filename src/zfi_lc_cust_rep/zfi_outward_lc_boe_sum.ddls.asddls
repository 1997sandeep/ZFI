@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC BOE Summary'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_LC_BOE_SUM 
as select from ZFI_OUTWARD_LC_BOEDETAIL as boe
{
  key boe.LCNumber as LCNumber,

      sum(
        cast( boe.BOEAmount as abap.dec(23,2) )
      ) as ClaimedUnderLC,

      sum(
        cast( boe.ReceivedAmount as abap.dec(23,2) )
      ) as AmountReceivedInLC
}
group by
  boe.LCNumber
