@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Number F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_VEND_F4
as select from zfi_inward_lc as LC
inner join ZFI_LC_MAX_AMOUNT_VER as AM
on  AM.CompanyCode      = LC.company_code
and AM.LCNumber         = LC.lc_number
and AM.MaxAmountVersion = LC.amount_version

inner join ZFI_LC_MAX_LSD_VER as LSD
on  LSD.CompanyCode   = LC.company_code
and LSD.LCNumber      = LC.lc_number
and LSD.MaxLsdVersion = LC.lsd_version

inner join ZFI_LC_MAX_ED_VER as ED
on  ED.CompanyCode  = LC.company_code
and ED.LCNumber     = LC.lc_number
and ED.MaxEdVersion = LC.ed_version

{
    key LC.lc_number      as LCNumber,
        LC.company_code   as CompanyCode,
        LC.lc_banknumber  as LCBankNumber,
        LC.vendor_code    as VendorCode,
        LC.vendor_name    as VendorName,
        LC.amount_version as AmountVersion,
        LC.lsd_version    as LsdVersion,
        LC.ed_version     as EdVersion
}
