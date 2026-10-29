@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report HSN Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_HSN_CODE1
 as select distinct from I_JournalEntryItem as a
 left outer join I_BillingDocumentItem as b
   on a.ReferenceDocument = b.BillingDocument
  and a.ReferenceDocumentItem = b.BillingDocumentItem
 left outer join I_ProductPlantBasic as c
   on b.Product = c.Product
  and b.Plant   = c.Plant
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.ReferenceDocument,
    a.ReferenceDocumentItem,
    c.ConsumptionTaxCtrlCode as hsn_code,
      case
      when c.ConsumptionTaxCtrlCode like '995%' then 'S'
      else 'G'
      end as HSNNature
} where a.ReferenceDocument <> ' '
    and a.ReferenceDocumentItem <> '000000'
    and a.AccountingDocumentType = 'RV'
group by a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.ReferenceDocument,
    a.ReferenceDocumentItem,
    c.ConsumptionTaxCtrlCode

// as select from I_BillingDocument as a
// left outer join I_BillingDocumentItem as b
//   on a.BillingDocument = b.BillingDocument
//{
//    key a.BillingDocument,
//    a.CompanyCode,
//    a.FiscalYear
//} where a.BillingDocumentType = 'RV'
