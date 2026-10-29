@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Number F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZLC_CUST_LCNO_F4 
as select from zfi_outward_lc
{
    key company_code as CompanyCode,
    key zlcnumber    as LcNumber
}
