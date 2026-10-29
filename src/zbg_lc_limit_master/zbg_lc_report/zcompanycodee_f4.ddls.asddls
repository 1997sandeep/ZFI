@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 For company code'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCOMPANYCODEE_F4 as select from I_CompanyCode
{
   key CompanyCode,
   CompanyCodeName 
}
