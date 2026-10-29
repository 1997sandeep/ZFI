@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report UOM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT2
  as select distinct from I_JournalEntryItem              as a
     left outer join       I_JournalEntryItem          as b   on  a.AccountingDocument = b.AccountingDocument
                                                             and a.CompanyCode        = b.CompanyCode
                                                             and a.FiscalYear         = b.FiscalYear
                                                             and a.LedgerGLLineItem = b.LedgerGLLineItem
                                                             
    left outer join       I_OperationalAcctgDocItem   as c   on  a.AccountingDocument   = c.AccountingDocument
                                                             and a.CompanyCode          = c.CompanyCode
                                                             and a.FiscalYear           = c.FiscalYear
                                                             and c.FinancialAccountType = 'K'
                                                             
    left outer  join       I_IN_BusinessPlaceTaxDetail as d   on c.BusinessPlace = d.BusinessPlace
    left outer  join       I_GLAccountText             as e   on b.GLAccount = e.GLAccount
    left outer  join       I_TaxCodeText               as g   on b.TaxCode = g.TaxCode
    left outer  join       I_ProfitCenterText          as h   on b.ProfitCenter = h.ProfitCenter



 left outer join           ZFI_GSTR2_CGST_SGST_ISGT_CDS     as bb  on  a.CompanyCode                 = bb.CompanyCode
                                                             and b.FiscalYear                   = bb.FiscalYear
                                                             and b.AccountingDocument           = bb.AccountingDocument
//                                                              and b.AccountingDocumentItem     = bb.AccountingDocumentItem  
                                                            and b.LedgerGLLineItem             = bb.LedgerGLLineItem                                                        
                                                             and bb.TaxCode                      = g.TaxCode  
                                                                                                                        
                                                             
//// for document ref item     

inner join I_JournalEntry as kav on  kav.AccountingDocument = a.AccountingDocument
                                           and kav.FiscalYear = a.FiscalYear
                                           and kav.CompanyCode = a.CompanyCode                                                                  
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                            








           

{
  key b.AccountingDocument,
  key b.LedgerGLLineItem,
   key b.FiscalYear,
   key b.CompanyCode,
      case
       when b.IsReversed = 'X'
         then 'Yes'
       else 'No'
      end                                                     as DocumentIsRevered,

      case
        when b.IsReversal = 'X'
          then 'Yes'
        else 'No'
      end                                                     as ReveredDocument,

      case
      when b.AmountInTransactionCurrency < 0
      then cast(b.AmountInTransactionCurrency  as abap.dec(30,2))
      else cast(b.AmountInTransactionCurrency as abap.dec(30,2))
      end                                                     as taxable_value,
      b.TaxCode,
      b.GLAccount                                             as expense_gl,
      e.GLAccountLongName                                     as expense_gl_name,
      c.BusinessPlace,
      d.BusinessPlaceDescription                              as bp_name,
      d.IN_GSTIdentificationNumber                            as bp_gstin,
      kav.DocumentReferenceID                                 as invoice_ref_no,
      b.AccountingDocumentType                                as document_type,
      b.DocumentDate,
      b.PostingDate,
      b.Product,
      cast(b.Quantity as abap.dec(15,2))                      as Quantity,

      case
       when b.TaxCode between 'RA' and 'RX'
       then 'Yes'
       else 'No'
       end                                                    as supply_attract_rev,

      g.TaxCodeName,
      b.ProfitCenter,
      h.ProfitCenterLongName,
//      cast(bb.AmountInCompanyCodeCurrency as abap.dec(13,2))  as igst,
//      cast(cc.AmountInCompanyCodeCurrency as abap.dec(13,2))  as sgst,
//       cast(cc.AmountInCompanyCodeCurrency as abap.dec(13,2)) as cgst,
//       cast(fi1.AmountInCompanyCodeCurrency as abap.dec(13,2)) as ugst

cast(bb.IGST as abap.dec(12,2)) as igst ,
cast(bb.CGST as abap.dec(12,2)) as cgst,
cast(bb.CGST as abap.dec(12,2)) as  sgst ,
cast(bb.ugst as abap.dec(12,2)
) as ugst






}

where
        b.Ledger                       =  '0L'
  and   b.TaxCode                      <> ' '

  and(
        b.AccountingDocumentType       <> 'DR'
    and b.AccountingDocumentType       <> 'RV'
    and b.AccountingDocumentType       <> 'DG'
    and b.AccountingDocumentType       <> 'SA'
    and b.AccountingDocumentType       <> 'KZ'
    and b.AccountingDocumentType       <> 'DZ'
    and b.AccountingDocumentType       <> 'SJ'
  )
  and(
        b.FinancialAccountType         =  'S'
    or  b.FinancialAccountType         =  'A'
  )

  and(
        b.TransactionTypeDetermination <> 'JIC'
    and b.TransactionTypeDetermination <> 'JIS'
    and b.TransactionTypeDetermination <> 'JRC'
    and b.TransactionTypeDetermination <> 'JRI'
    and b.TransactionTypeDetermination <> 'WIT'
  )
  and(
        b.GLAccount                    <> '0022800001'
    and b.GLAccount                    <> '0022800002'
    and b.GLAccount                    <> '0022800003'
    and b.GLAccount                    <> '0010700001'
    and b.GLAccount                    <> '0010700002'
    and b.GLAccount                    <> '0010700003'
    and b.GLAccount                    <> '0010700004'
    and b.GLAccount                    <> '0020500005'
    and b.GLAccount                    <> '0020500006'
    and b.GLAccount                    <> '0020500007'
    and b.GLAccount                    <> '0020500008'
    and b.GLAccount                    <> '0050300106'
  )
//group by
//  b.AccountingDocument,
//  b.CompanyCode,
//  b.FiscalYear,
//  b.LedgerGLLineItem,
//  b.IsReversed,
//  b.IsReversal,
//  b.AmountInTransactionCurrency,
//  b.TaxCode,
//  b.GLAccount,
//  b.Quantity,
//  e.GLAccountLongName,
//  c.BusinessPlace,
//  d.BusinessPlaceDescription,
//  d.IN_GSTIdentificationNumber,
//  a.DocumentReferenceID,
//  b.AccountingDocumentType,
//  b.DocumentDate,
//  b.PostingDate,
//  b.Product,
//  g.TaxCodeName,
//  b.ProfitCenter,
//  h.ProfitCenterLongName,
//    bb.AmountInCompanyCodeCurrency,
//    cc.AmountInCompanyCodeCurrency,
//    fi1.AmountInCompanyCodeCurrency
  

