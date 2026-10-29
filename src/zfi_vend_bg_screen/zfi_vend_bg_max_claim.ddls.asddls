@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor BG Max Claim Version'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_MAX_CLAIM 
as select from zfi_vendor_bg as V
    inner join ZFI_VEND_BG_MAX_VER as M
      on  M.BGNumber             = V.zdocumentnumber
      and M.MaxExtensionVersion  = V.zbgextensionversion
{
  key V.zdocumentnumber          as BGNumber,

      max( V.zbgclaimextensionversion ) as MaxClaimExtensionVersion
}
group by V.zdocumentnumber
