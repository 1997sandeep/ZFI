@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'supplier f4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_TNS_F4_SUPP as select from I_Supplier
{
    key Supplier
}
