@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For BG/LC Limit Master'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BG_LC_LIMIT_cds as select from zbg_lc_li_mas_t
//composition of target_data_source_name as _association_name
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
    remarks as Remarks,
    createdby as Createdby,
    createdon as Createdon,
    changedby as Changedby,
    changedon as Changedon
//    _association_name // Make association public
}
