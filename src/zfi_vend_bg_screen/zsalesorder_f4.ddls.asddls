@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales order'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSALESORDER_F4 as select from I_SalesContract as a
{
  key a.SalesContract  
}
