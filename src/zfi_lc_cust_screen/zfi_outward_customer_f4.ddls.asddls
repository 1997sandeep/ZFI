@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_CUSTOMER_F4 
//as select from I_Customer
as select from I_Supplier
{                                
   key  Supplier as  Customer,
      SupplierName as  CustomerName    
}
