@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_OUTWARD_LC_REPORT
as select from zfi_outward_lc as lc
left outer join ZFI_OUTWARD_LC_JOB_SUM as job
on job.LCNumber = lc.zlcnumber
                  
left outer join ZFI_OUTWARD_LC_BOE_SUM as boe
on boe.LCNumber = lc.zlcnumber
         
{
  key lc.zlcnumber              as LCNumber,
        
      lc.job_no                 as JobNo,
         
      lc.customer_code          as CustomerCode,

      lc.customer_name          as CustomerName,

      lc.zlcdate                as LCDate,

      lc.zlctype                as LCType,

      lc.zlcissuingbank         as LCIssuingBank,

      lc.zlcnegotiatingbank     as LCNegotiatingBank,

      lc.zlastshipmentdate      as LatestShipmentDate,

      lc.zlsdversion            as LSDVersion,

      lc.zexpirydate            as ExpiryDate,

      lc.zedversion             as EDVersion,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      lc.order_amount_gst       as OrderAmountIncludingGST,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      lc.zlcamount              as LCAmount,

      lc.zlcamountversion       as LCAmountVersion,

      job.BilledUnderLC        as BilledUnderLC,
            
      cast(   
        cast( lc.zlcamount as abap.dec(23,2) )
        -  
        coalesce( job.BilledUnderLC, 0 )
        as abap.dec(23,2)
      )                         as BillingBalanceInLC,

      boe.ClaimedUnderLC      as ClaimedUnderLC,

      cast(
        coalesce( job.BilledUnderLC, 0 )
        -
        coalesce( boe.ClaimedUnderLC, 0 )
        as abap.dec(23,2)
      )                         as BalanceToClaim,

      boe.AmountReceivedInLC  as AmountReceivedInLC,

      cast(
        coalesce( boe.ClaimedUnderLC, 0 )
        -
        coalesce( boe.AmountReceivedInLC, 0 )
        as abap.dec(23,2)
      )                         as BOELodgedPaymentAwaited,

      dats_days_between(
        $session.system_date,
        lc.zlastshipmentdate
      )                         as DaysRemainsForShipment,

      dats_days_between(
        $session.system_date,
        lc.zexpirydate
      )                         as DaysRemainsForExpiry,

      lc.zstatus                as Remarks,

      lc.zdescrepancies         as Discrepancies,

      lc.currency_code          as CurrencyCode

}
