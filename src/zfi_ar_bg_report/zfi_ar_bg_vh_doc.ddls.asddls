@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AR BG Customer Vendor Document Value Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_AR_BG_VH_DOC 
as select distinct from ZFI_AR_BG_VH_BASE
{
    key BGNumber
}
