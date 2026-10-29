@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Place F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_BUSINESS_PLACE_F4 
as select distinct from I_BusinessPlaceVH
{
    key CompanyCode,
    key BusinessPlace,
    BusinessPlaceDescription
} where BusinessPlace <> ' '

group by CompanyCode,
BusinessPlace,
BusinessPlaceDescription
