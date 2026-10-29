@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_CUSTOMER_F4 
as select from I_Customer
{          
  @Search.defaultSearchElement: true
  key Customer,
              
  @Search.defaultSearchElement: true
  CustomerName 
}
