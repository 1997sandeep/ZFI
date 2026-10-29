@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maximum Amount Version'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_LC_MAX_AMOUNT_VER
  as select from zfi_inward_lc as LC
{
    key LC.company_code    as CompanyCode,
    key LC.lc_number       as LCNumber,

        max( LC.amount_version ) as MaxAmountVersion
}
group by
    LC.company_code,
    LC.lc_number
