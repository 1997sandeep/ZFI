@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 for bankl'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_CUST_BG_BANK_F4 as select from I_Bank_2 as a
{                                                        
    key a.BankInternalID     as BankIFSC,
        a.BankName           as BankName,
        a.StreetName         as BankAddress
}              
