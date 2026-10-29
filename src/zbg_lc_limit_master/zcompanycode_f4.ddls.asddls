@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COMPANYCODE F4  Help'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCOMPANYCODE_F4 as select from I_CompanyCode
{
key CompanyCode as Companycode,
    CompanyCodeName
    
} 
