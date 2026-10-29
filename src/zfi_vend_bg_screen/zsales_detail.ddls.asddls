@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'customer details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSALES_DETAIL as select from I_SalesContract as a
left outer join I_Customer as b on b.Customer = a.SoldToParty
//left outer join I_Address_2 as c on c.AddressID = b.AddressID

{
    key a.SalesContract,
    a.SoldToParty as customercode,
    b.StreetName,
    b.CityCode,
    b.PostalCode,
    concat(
        concat(
            b.StreetName,
            concat( ', ', b.CityCode )
        ),
        concat( '-', b.PostalCode )
    ) as FullAddress
}
