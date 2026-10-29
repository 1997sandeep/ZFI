@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_PO_F4 
as select from I_PurchaseOrderAPI01 as a
left outer join I_Supplier as b on
a.Supplier = b.Supplier      
{                   
    key a.PurchaseOrder     as PurchaseOrder,
        b.Supplier          as Vendor,
        b.SupplierName      as VendorName,
        b.BPAddrStreetName  as VendorAddress
}                  
