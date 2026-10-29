@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 - HSN code/ Nature'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR2_HSN_SAC
  as select from I_OperationalAcctgDocItem

{

  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
      IN_HSNOrSACCode,
      case
      when IN_HSNOrSACCode like '995%' then 'S'
      else 'G'
      end as HSNNature
}
where
  IN_HSNOrSACCode is not initial
