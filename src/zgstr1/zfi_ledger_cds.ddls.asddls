@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds ledger item'
@Metadata.ignorePropagatedAnnotations: true
define view entity zfi_ledger_cds as select from ZFI_GSTR1_REPORT1_TAX_CODE
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
        min(LedgerGLLineItem) as line_min
}
group by
    AccountingDocument,
    CompanyCode,
    FiscalYear
