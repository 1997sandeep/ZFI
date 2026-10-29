@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'f4 for supplier'
@Metadata.ignorePropagatedAnnotations: true
define view entity zsupplier_f4 as select from I_Supplier
{
    key Supplier
}
