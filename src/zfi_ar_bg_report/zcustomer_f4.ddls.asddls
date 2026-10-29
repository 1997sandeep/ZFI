@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 for customer'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCUSTOMER_F4 as select from I_Customer
{
    key Customer
}
