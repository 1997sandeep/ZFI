@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'House Bank Acount ID F4 Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity zHouseBank_id_f4 as select from I_HouseBankAccountLinkage as a
//left outer join I_HouseBankAccount as a on a.HouseBank = b.HouseBank
{
    key a.HouseBankAccount as Accountid
}
