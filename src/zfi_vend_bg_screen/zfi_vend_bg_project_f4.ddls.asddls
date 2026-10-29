@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds for Project ID F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_PROJECT_F4 
as select from I_EnterpriseProject as a
{                                                  
    key a.Project,
        a.ProfitCenter
}                          
