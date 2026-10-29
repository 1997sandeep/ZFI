@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS CDS SGST AND IGST'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_GSTR2_CGST_SGST_ISGT_CDS
 as select distinct from I_OperationalAcctgDocItem as a  
                   left outer join I_OperationalAcctgDocItem as b on ( b.CompanyCode = a.CompanyCode and b.FiscalYear = a.FiscalYear
                                                                       and b.OriginalReferenceDocument = a.OriginalReferenceDocument
//                                                                         and b.AccountingDocument = a.AccountingDocument 
                                                                       and b.TaxItemGroup = a.TaxItemGroup 
                                                                       and b.TransactionTypeDetermination = 'JII' )
                                                                       
                   left outer join I_OperationalAcctgDocItem as c on ( c.CompanyCode = a.CompanyCode and c.FiscalYear = a.FiscalYear
                   
                                                                       and c.AccountingDocument = a.AccountingDocument 
                                                                       and c.OriginalReferenceDocument = a.OriginalReferenceDocument 
//                                                                       and c.TaxItemGroup = a.TaxItemGroup 
                                                                       and c.TransactionTypeDetermination = 'JIC' )
                                                                       
                   left outer join I_OperationalAcctgDocItem as d on ( d.CompanyCode = a.CompanyCode and d.FiscalYear = a.FiscalYear
                                                                       and d.OriginalReferenceDocument = a.OriginalReferenceDocument
                                                                         and d.AccountingDocument = a.AccountingDocument  
                                                                       and d.TaxItemGroup = a.TaxItemGroup 
                                                                       and d.TransactionTypeDetermination = 'JIU' )
//                   
                   left outer join I_SupplierInvoiceAPI01 as H on ( H.SupplierInvoiceWthnFiscalYear = a.OriginalReferenceDocument )                                                     
{
   key a.CompanyCode,
   key a.OriginalReferenceDocument,
   key a.FiscalYear,
       a.AccountingDocument,
//       a.AccountingDocumentItem,
       a.LedgerGLLineItem,
//       a.TaxItemGroup,
       a.PurchasingDocument,
       a.PurchasingDocumentItem,
       a.WBSElementInternalID,
       a.Material,
       a.TaxCode,
       a.BaseUnit,
       @Semantics: { quantity : {unitOfMeasure: 'BaseUnit'} }
       a.Quantity as InvoiceQty,
       a.CompanyCodeCurrency,
//       @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
//       a.AmountInCompanyCodeCurrency,
       @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
       b.AmountInCompanyCodeCurrency as IGST,
       @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
       c.AmountInCompanyCodeCurrency as CGST,
       @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
       c.AmountInCompanyCodeCurrency as SGST,
        @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
       d.AmountInCompanyCodeCurrency as ugst
     
} 
where 
// a.TransactionTypeDetermination = 'WRX'
    ( a.AccountingDocumentType = 'RE' or 
  a.AccountingDocumentType = 'KR'  or a.AccountingDocumentType = 'KG' or
   a.AccountingDocumentType = 'KA'   )
        
//     and H.ReverseDocument = ''
