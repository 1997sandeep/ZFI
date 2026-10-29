@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'f4 for profitcentre'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPROFIT_CENTER as select from I_ProfitCenterText
{
    key ProfitCenter
}
