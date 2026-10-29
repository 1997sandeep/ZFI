@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZLC_CUST_CUSTOMER_F4 
as select from I_Customer
{          
   key Customer,
   CustomerName    
}
