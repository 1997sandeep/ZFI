@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_PROJECT_F4 
as select from I_EnterpriseProject as a
left outer join I_CompanyCode as b on
a.CompanyCode = b.CompanyCode
{                                    
  @Search.defaultSearchElement: true
  key a.Project,
                                        
  @Search.defaultSearchElement: true
  a.ProjectDescription,
                 
  @Search.defaultSearchElement: true
  b.CompanyCode
}
