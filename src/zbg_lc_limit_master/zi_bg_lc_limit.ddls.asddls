@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table for BG/LC Limit Master'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BG_LC_LIMIT
  as select from zbg_lc_li_mas_t
  //composition of target_data_source_name as _association_name
{
  key companycode,
  key housebank,
  key accountid,

      bankname,
      currency_key,
      bg_limit,
      lc_limit,
      effective_from,
      effective_to,
      remarks,

      createdby,
      createdon,
      changedby,
      changedon
      //    _association_name // Make association public
}
