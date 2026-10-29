@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_PROFIT_CENTER_F4 
as select from I_ProfitCenter
{          
    key ProfitCenter
}            
