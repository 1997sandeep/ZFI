@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inward LC BOE Master Data'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZFI_ILC_BOE_CDS
as select from zfi_ilc_boe as boe
left outer join I_CompanyCode as Comp
on Comp.CompanyCode = boe.drawee_name
{
    key boe.boe_ref_number  as BoeRefNumber,

        boe.boe_type        as BoeType,

        boe.lc_number       as LcNumber,

        boe.drawee_name     as DraweeName,
        boe.drawer_name     as DrawerName,
        
        Comp.CompanyCodeName     as DraweeDesc,
        boe.drawer_desc     as DrawerDesc,

        boe.booking_date    as BookingDate,
        boe.applicable_date as ApplicableDate,
        boe.maturity_date   as MaturityDate,
        boe.boe_amount      as BoeAmount,
        boe.currency        as Currency,
        boe.order_number    as OrderNumber,

        boe.descrepencies   as Descrepencies,
        
        boe.createdon       as Createdon,
        boe.createdat       as Createdat,
        boe.createdby       as Createdby,
        boe.changedon       as Changedon,
        boe.changedat       as Changedat,
        boe.changedby       as Changedby,
        boe.lastchanged     as Lastchanged
}
