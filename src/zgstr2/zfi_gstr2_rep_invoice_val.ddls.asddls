@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report Invoice Value'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REP_INVOICE_VAL 
 as select from ZFI_GSTR2_REPORT_TAX_VAL
{
  key AccountingDocument,
  CompanyCode,
  FiscalYear,
  LedgerGLLineItem,
  taxable_value,
  sgst_amount,
  cgst_amount,
  igst_amount,
  ugst_amount,
  rcm_sgst_with_itc,
  rcm_cgst_with_itc,
  rcm_igst_with_itc,
  rcm_ugst_with_itc,
  
  cast( coalesce(taxable_value,0) +
      coalesce(sgst_amount,0) +
      coalesce(cgst_amount,0) +
      coalesce(igst_amount,0) +
      coalesce(ugst_amount,0) -
      coalesce(rcm_sgst_with_itc,0) -
      coalesce(rcm_cgst_with_itc,0) -
      coalesce(rcm_igst_with_itc,0) -
      coalesce(rcm_ugst_with_itc,0) 
      as abap.dec(30,2)) as invoice_value
//  cast( cast( sgst_amount as abap.fltp) + cast(cgst_amount as abap.fltp) +
//        cast( igst_amount as abap.fltp) + cast(ugst_amount as abap.fltp)
//        as abap.dec(30,2)) as invoice_value
}
//   as select from I_JournalEntryItem as b
// left outer join C_SupplierInvoiceItemDEX as c
//   on b.ReferenceDocument = c.SupplierInvoice
//  and b.PurchasingDocument = c.PurchaseOrder
//  and b.PurchasingDocumentItem = c.PurchaseOrderItem
//{
//    key b.AccountingDocument,
//    b.CompanyCode,
//    b.FiscalYear,
//    b.LedgerGLLineItem,
//    b.ReferenceDocument,
//    b.PurchasingDocument,
//    b.PurchasingDocumentItem,
//    cast(c.SupplierInvoiceItemAmount as abap.dec(30,2)) as invoice_value
//  
//}where
//       b.Ledger = '0L'
//  and  b.TaxCode <> ' '
//  and  b.PurchasingDocument <> ' '
//  
//  and( b.AccountingDocumentType <> 'DR'
//   and b.AccountingDocumentType <> 'RV'
//   and b.AccountingDocumentType <> 'DG'
//   and b.AccountingDocumentType <> 'SA'
//   and b.AccountingDocumentType <> 'KZ'
//   and b.AccountingDocumentType <> 'DZ'
//  )  
//  and(
//       b.FinancialAccountType         = 'S'
//    or b.FinancialAccountType         = 'A'
//  )
//    
//  and(
//        b.TransactionTypeDetermination <> 'JIC'
//    and b.TransactionTypeDetermination <> 'JIS'
//    and b.TransactionTypeDetermination <> 'JRC'
//    and b.TransactionTypeDetermination <> 'JRI'
//    and b.TransactionTypeDetermination <> 'WIT'
//  )
//  and (
//      b.GLAccount <> '0022800001'
//   and b.GLAccount <> '0022800002'
//   and b.GLAccount <> '0022800003'
//   and b.GLAccount <> '0010700001'
//   and b.GLAccount <> '0010700002'
//   and b.GLAccount <> '0010700003'
//   and b.GLAccount <> '0010700004'
//   and b.GLAccount <> '0020500005'
//   and b.GLAccount <> '0020500006'
//   and b.GLAccount <> '0020500007'
//   and b.GLAccount <> '0020500008'
//  )
// group by b.AccountingDocument,
//    b.CompanyCode,
//    b.FiscalYear,
//    b.LedgerGLLineItem,
//    b.ReferenceDocument,
//    b.PurchasingDocument,
//    b.PurchasingDocumentItem,
//    c.SupplierInvoiceItemAmount
