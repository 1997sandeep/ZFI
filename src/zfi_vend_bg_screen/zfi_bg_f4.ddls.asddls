@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BG F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_BG_F4 
//as select from ZFI_VEND_BG_BGNO_F4
//{                                  
//    key BGNumber,
//        BGBankNumber
//} 

as select from ZFI_VEND_BG_BGNO_F4
{
    key BGNumber,
    key BGClaimExtensionVersion,
    key BGExtensionVersion,
        BGBankNumber
}
