@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company Code F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_COMPANY_CODE_F4 
as select from I_CompanyCode
{
  @Search.defaultSearchElement: true
  key CompanyCode,

  @Search.defaultSearchElement: true
  CompanyCodeName
}
