@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC BOE Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_OUTWARD_LC_BOEDETAIL 
as select distinct from zfi_olc_boe as boe
left outer join zfi_outward_lc as lc
on lc.zlcnumber = boe.zlcnumber
                                                                                                            
left outer join I_EnterpriseProject as project
on project.Project = lc.job_no
                                               
left outer join ZFI_OUTWARD_LC_BOE_REC as rec
on rec.AccountingDocument = boe.zbillingdoc
{                         
  key boe.zlcnumber          as LCNumber,
  key boe.zboeno             as BOENo,
                  
      cast(              
        substring(
          cast( boe.zboedate as abap.char(8) ),
          1,     
          4    
        )                        
        as abap.char(4) )     as FinancialYear,
      boe.zboedate            as BOEDate,
      boe.zboetype            as BOEType,
      @Semantics.amount.currencyCode: 'BOECurrency'
      boe.zboeamount          as BOEAmount,
      lc.zlcissuingbank       as IssuingBank,
      lc.job_no               as JobNo,
      project.ProjectDescription     as JobName,
      rec.ReceivedAmount,
                                                              
      cast(       
        cast( boe.zboeamount as abap.dec(23,2) )
        -          
        cast( rec.ReceivedAmount as abap.dec(23,2) )
        as abap.dec(23,2)  
      ) as PaymentAwaited,
               
      rec.ReceivedDate,
                      
      boe.zpaymentstatus      as PaymentRemarks,
      boe.zcurrency           as BOECurrency,
          
      dats_days_between(
        boe.zboedate,
        $session.system_date
      )                       as BOELodgedDueDays,
                               
      case
        when boe.zpaymentstatus is not initial
        then
          dats_days_between(
            boe.zboedate,
            boe.zapplicabledate
          )
        else
          0
      end                     as DaysTaken

}
