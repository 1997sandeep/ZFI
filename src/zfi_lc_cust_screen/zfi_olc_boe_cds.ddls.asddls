@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC BOE Master Data'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_OLC_BOE_CDS 
as select from zfi_olc_boe
{                                  
    key zlcnumber   as Zlcnumber,
    key zboeno      as Zboeno,              
    zboedate        as Zboedate,
    zboetype        as Zboetype,
    zbillingdoc     as Zbillingdoc,
    @Semantics.amount.currencyCode : 'Zcurrency'
    zinvoiceamt     as Zinvoiceamt,
    @Semantics.amount.currencyCode : 'Zcurrency'
    zboeamount      as Zboeamount,
    zcurrency       as Zcurrency,
    zapplicabledate as Zapplicabledate,
    zboeduedate     as Zboeduedate,
    zboestatus      as Zboestatus,
    zremarks        as Zremarks,
    zpaymentstatus  as Zpaymentstatus,
    zdescrepancies  as Zdescrepancies,
    created_by      as CreatedBy,
    created_at      as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt
}                                     
