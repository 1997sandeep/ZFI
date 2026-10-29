@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report UOM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_UOM
 as select from ZFI_GSTR1_REPORT1_TAX_CODE as a
    inner join I_UnitOfMeasureText as u
      on a.BaseUnit = u.UnitOfMeasure
      and u.Language = $session.system_language
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.BaseUnit,
    min(u.UnitOfMeasureName) as uom
}
where a.BaseUnit <> ' '
group by
    a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.BaseUnit

