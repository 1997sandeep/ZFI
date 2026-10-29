@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maximum ED Version'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_LC_MAX_ED_VER
  as select from zfi_inward_lc as LC
{
    key LC.company_code    as CompanyCode,
    key LC.lc_number       as LCNumber,

        max( LC.ed_version ) as MaxEdVersion
}
group by
    LC.company_code,
    LC.lc_number
