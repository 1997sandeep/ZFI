@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Display data for bglc'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBGLC_DISPLAY as select from zbg_lc_li_mas_t
{
    key companycode as Companycode,
    key housebank as Housebank,
    key accountid as Accountid,
    bankname as Bankname,
    currency_key as CurrencyKey,
    bg_limit as BgLimit,
    lc_limit as LcLimit,
    effective_from as EffectiveFrom,
    effective_to as EffectiveTo,
    remarks as Remarks
}
