@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC Master Data'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_OUTWARD_LC_CDS 
as select from zfi_outward_lc
{                                      
    key zlcnumber      as Zlcnumber,
    lc_banknumber      as LcBanknumber,
    company_code       as CompanyCode,
    job_no             as JobNo,             
    sales_order        as SalesOrder,   
    customer_code      as CustomerCode,
    customer_name      as CustomerName,
    zlcdate            as Zlcdate,   
    zlctype            as Zlctype,     
    zlcissuingbank     as Zlcissuingbank,
    zlcnegotiatingbank as Zlcnegotiatingbank,
    zlastshipmentdate  as Zlastshipmentdate,
    zlsdversion        as Zlsdversion, 
    zexpirydate        as Zexpirydate,
    zedversion         as Zedversion, 
    zlcpercent         as Zlcpercent,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    order_amount_basic as OrderAmountBasic,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    gst_amount         as GstAmount,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    order_amount_gst   as OrderAmountGst,
    @Semantics.amount.currencyCode : 'CurrencyCode'
    zlcamount          as Zlcamount,    
    zlcamountversion   as Zlcamountversion,
    tds_percentage     as TdsPercentage,
    zboedueperiod      as Zboedueperiod,
    zremarks           as Zremarks,       
    zstatus            as Zstatus,
    zdescrepancies     as Zdescrepancies,
    currency_code      as CurrencyCode,
    created_by         as CreatedBy,
    created_at         as CreatedAt,
    last_changed_by    as LastChangedBy,
    last_changed_at    as LastChangedAt
}              
