@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor Bank Amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBG_VENDOR_BANK as select from ZFI_VEND_BG_REPORT as a
left outer join I_Housebank as b on a.Zbankifsc = b.BankInternalID

{
    key a.Zbankifsc,
    b.HouseBank,
   sum( cast( a.Zbgamount as abap.dec( 12, 2 ) ) ) as vend_amount
} where b.HouseBank is not initial
group by a.Zbankifsc,
b.HouseBank

