@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer bank amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBG_CUSTOMER_BANK as select from ZFI_AR_BG_REPORT as a
left outer join I_Housebank as b on a.Zbankifsc = b.BankInternalID
{
    key a.Zbankifsc,
    key b.HouseBank,
    sum( a.Zbgamount ) as cust_amount
} where b.HouseBank is not initial
group by a.Zbankifsc,
    b.HouseBank
