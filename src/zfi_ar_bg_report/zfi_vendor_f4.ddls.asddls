@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VENDOR_F4 
as select from I_Supplier
{                                 
    @Search.defaultSearchElement: true
    key Supplier,
                 
    @Search.defaultSearchElement: true
    SupplierName
}               
