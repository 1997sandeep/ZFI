@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_PO_F4 
as select from I_PurchaseOrderAPI01 as a
{
    key a.PurchaseOrder     as PONo,
        a.CreationDate      as PODate
}
