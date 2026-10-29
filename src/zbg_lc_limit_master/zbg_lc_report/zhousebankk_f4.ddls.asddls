@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Housebank_f4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZHOUSEBANKK_F4 as select from I_Housebank as b 
left outer join I_HouseBankAccountLinkage as c on c.HouseBank = b.HouseBank
left outer join I_Bank_2 as d on d.BankInternalID = b.BankInternalID
{
   key b.HouseBank,
   b.BankInternalID,
   c.BankName,
   d.CityName
}
   
   
    
