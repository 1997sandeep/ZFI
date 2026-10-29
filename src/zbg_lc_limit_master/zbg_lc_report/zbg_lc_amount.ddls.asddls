@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer bank amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBG_LC_AMOUNT as select from ZBG_CUSTOMER_BANK as a
left outer join ZBG_VENDOR_BANK as b on a.HouseBank = b.HouseBank
{
    key case 
     when a.HouseBank is initial then b.HouseBank
      else b.HouseBank end as HouseBank,
    coalesce (a.cust_amount, 0 ) +  coalesce (b.vend_amount , 0 )    as bg_amount
      
}
 where b.HouseBank is not initial
group by 
    b.HouseBank,
    a.HouseBank,
    a.cust_amount,
    b.vend_amount
