@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bank F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_BANK_F4 
as select from I_Bank_2 as a
{                                                        
    key a.BankInternalID     as BankIFSC,
        a.BankName           as BankName,
        a.StreetName         as BankAddress
}                                               
