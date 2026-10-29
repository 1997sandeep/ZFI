@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC AMOUNT'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZLC_SCREEN_DATA as select from ZFI_INWARD_LC_CDS as A
left outer join I_Housebank as b on A.Zbankifsc = b.BankInternalID
left outer join I_HouseBankAccountLinkage as c on c.HouseBank  = b.HouseBank
{

key b.HouseBank,
key c.HouseBankAccount as accid,
   A.Zbankifsc,
   A.LcCurrency,
   @Semantics.amount.currencyCode: 'LcCurrency'
   A.LcAmount 
} where b.HouseBank is not initial and A.LcAmount is not initial
