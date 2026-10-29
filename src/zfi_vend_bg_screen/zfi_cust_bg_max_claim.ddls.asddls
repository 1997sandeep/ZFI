@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer BG Max Claim Version'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_CUST_BG_MAX_CLAIM 
as select from zfi_customer_bg as C
    inner join ZFI_CUST_BG_MAX_VER as M
      on  M.BGNumber            = C.zslno
      and M.MaxExtensionVersion = C.zbgextensionversion
{
  key C.zslno as BGNumber,

      max( C.zbgclaimextensionversion ) as MaxClaimExtensionVersion
}
group by C.zslno
