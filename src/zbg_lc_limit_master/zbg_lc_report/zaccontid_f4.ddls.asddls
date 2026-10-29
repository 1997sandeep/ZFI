@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Accountid f4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZACCONTID_F4 as select from I_HouseBankAccountLinkage as a

{
    key a.HouseBankAccount ,
    a.BankInternalID,
    a.BankName
}
