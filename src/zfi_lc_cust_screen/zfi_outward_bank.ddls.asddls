@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bank Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_BANK 
as select from I_Bank_2
{      
  key BankInternalID,
      BankName    
}        
