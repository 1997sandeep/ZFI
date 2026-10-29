@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maximum LSD Version'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_LC_MAX_LSD_VER
  as select from zfi_inward_lc as LC
{
    key LC.company_code    as CompanyCode,
    key LC.lc_number       as LCNumber,

        max( LC.lsd_version ) as MaxLsdVersion
}
group by
    LC.company_code,
    LC.lc_number
