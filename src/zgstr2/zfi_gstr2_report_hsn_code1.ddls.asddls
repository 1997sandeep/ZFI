@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report HSN Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT_HSN_CODE1 
 as select distinct from I_JournalEntryItem as a
 left outer join I_ProductPlantBasic as c
   on a.Product = c.Product
  and a.Plant   = c.Plant
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.ReferenceDocument,
    a.ReferenceDocumentItem,
    c.ConsumptionTaxCtrlCode as hsn_code
} where a.ReferenceDocument <> ' '
    and a.ReferenceDocumentItem <> '000000'
    and a.AccountingDocumentType = 'RE'
    and c.ConsumptionTaxCtrlCode <> ' '
group by a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.ReferenceDocument,
    a.ReferenceDocumentItem,
    c.ConsumptionTaxCtrlCode
