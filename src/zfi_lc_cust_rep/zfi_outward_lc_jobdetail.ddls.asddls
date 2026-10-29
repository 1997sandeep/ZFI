@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC Job Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_OUTWARD_LC_JOBDETAIL 
as select distinct from zfi_outward_lc as lc
left outer join I_EnterpriseProject as project
on project.Project = lc.job_no
                                                                    
left outer join I_EnterpriseProjectElement as element
on element.ProjectInternalID = project.ProjectInternalID
and element.WBSElementIsBillingElement is not initial
                                
left outer join I_SalesOrderItem as soitem
on soitem.WBSElementInternalID = element.WBSElementInternalID
                                        
left outer join I_BillingDocumentItem as billitem
on billitem.SalesDocument = soitem.SalesOrder
                                              
left outer join I_BillingDocument as bill
on bill.BillingDocument = billitem.BillingDocument
                                 
left outer join zfi_olc_boe as boe
on boe.zlcnumber = lc.zlcnumber      

{
  key lc.zlcnumber          as LCNumber,

  key lc.job_no             as JobNo,

      lc.company_code       as CompanyCode,
      lc.sales_order        as SalesOrder,
      lc.customer_code      as CustomerCode,
      lc.customer_name      as CustomerName,

      lc.zlcdate             as LCDate,
      lc.zlctype             as LCType,

      lc.zlcpercent          as LCPercent,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      lc.order_amount_basic  as OrderAmountBasic,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      lc.order_amount_gst    as OrderAmountGST,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      lc.zlcamount            as LCAmount,
                                                           
      lc.zlcamountversion     as LCAmountVersion,
                                    
      lc.tds_percentage       as TDSPercentage,
     
      lc.zboedueperiod        as BOEDuePeriod,

      lc.zremarks             as Remarks,
      lc.zstatus              as Status,
      lc.zdescrepancies       as Discrepancies,

      bill.BillingDocumentType       as VoucherType,

      bill.BillingDocument           as VoucherNo,

      bill.BillingDocumentDate       as VoucherDate,

       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      billitem.MRPRequiredQuantityInBaseUnit as Quantity,

      billitem.BaseUnit,


      @Semantics.amount.currencyCode: 'CurrencyCode'
      bill.TotalNetAmount             as BasicValue,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      bill.TotalTaxAmount             as GSTAmount,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      (
        bill.TotalNetAmount + bill.TotalTaxAmount
      )                               as GrossTotal,
                 
      boe.zboeno                      as BoeNo,
      
      @Semantics.amount.currencyCode : 'Currency'
      boe.zboeamount                  as BoeAmount,
                      
      @Semantics.amount.currencyCode : 'Currency'
      case                         
        when lc.tds_percentage > 0
        then
          cast( boe.zboeamount as abap.dec(23,2) )
          -       
          (                                         
            cast( boe.zboeamount as abap.dec(23,2) )
            *    
            cast( lc.tds_percentage as abap.dec(5,2) )
            / 100
          )            
        else              
          cast( boe.zboeamount as abap.dec(23,2) )
      end as NetBOEAmount,
      
      boe.zcurrency                    as Currency,

      lc.currency_code                as CurrencyCode

}
