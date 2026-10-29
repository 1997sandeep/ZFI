@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'House Bank F4 Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity zHouseBank_f4 as select from I_Housebank as b 
left outer join I_HouseBankAccountLinkage as c on c.HouseBank = b.HouseBank
{
   key b.HouseBank,
   c.BankName

     
    
}
