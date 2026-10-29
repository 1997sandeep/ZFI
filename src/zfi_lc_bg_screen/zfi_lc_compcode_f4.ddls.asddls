@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company Code F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_COMPCODE_F4 
as select from I_CompanyCode
{
    key CompanyCode,
    CompanyCodeName
}
