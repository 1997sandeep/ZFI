@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AR BG Customer Vendor Document Base'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_AR_BG_VH_BASE 
as select distinct from zfi_customer_bg as C
{
    key C.zslno as BGNumber
}

union

select distinct from zfi_vendor_bg as V
{
    key V.zdocumentnumber as BGNumber
}
