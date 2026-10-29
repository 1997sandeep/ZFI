@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor BG Max Extension Version'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_MAX_VER 
as select from zfi_vendor_bg
{
  key zdocumentnumber as BGNumber,

      max( zbgextensionversion ) as MaxExtensionVersion
}
group by zdocumentnumber
