@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bank F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_BANK_F4 
as select from I_Bank_2
{                     
  key BankInternalID,
      BankName    
}               
