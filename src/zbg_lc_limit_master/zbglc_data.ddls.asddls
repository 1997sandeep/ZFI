@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for BG/LC Master Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBGLC_DATA as select from I_Housebank as b 
left outer join I_HouseBankAccountLinkage as c on c.HouseBank = b.HouseBank
{
   key b.HouseBank,
   c.BankName
//   '' as BG_Limit,
//   '' as LC_Limit,
//   'INR' as currency,
//   '' as BGLimit,
//   '' as Effective_From_Date,
//   '' as Effective_To_Date,
//   '' as Remarks
   
   
    
}
