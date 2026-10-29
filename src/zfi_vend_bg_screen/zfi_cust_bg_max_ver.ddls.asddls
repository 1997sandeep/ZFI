@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer BG Max Extension Version'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_CUST_BG_MAX_VER 
as select from zfi_customer_bg
{
  key zslno as BGNumber,

      max( zbgextensionversion ) as MaxExtensionVersion
}
group by zslno
