@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report om infra Invoice Reference No.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_INV_REF_NO 
as select from ZFI_GSTR1_REPORT_INV_REF_NO1
{
    key AccountingDocument,
    CompanyCode,
    FiscalYear,
    AccountingDocumentType,
    InvoiceNo,
    LedgerGLLineItem
} where InvoiceNo <> ' ' 
and LedgerGLLineItem = '000001'

group by AccountingDocument,
    CompanyCode,
    FiscalYear,
    AccountingDocumentType,
    InvoiceNo,
    LedgerGLLineItem
