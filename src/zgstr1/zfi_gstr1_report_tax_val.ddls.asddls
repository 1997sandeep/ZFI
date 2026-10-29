@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REPORT_TAX_VAL
  as select from ZFI_GSTR1_REPORT1_TAX_CODE as a
  left outer join I_TaxCodeRate as b
  on a.TaxCode = b.TaxCode
 and b.VATConditionType = 'JOIG' 
 left outer join I_TaxCodeRate as c
  on a.TaxCode = c.TaxCode
 and c.VATConditionType = 'JOCG'
 left outer join I_TaxCodeRate as d
  on a.TaxCode = d.TaxCode
 and d.VATConditionType = 'JOSG'
 left outer join I_TaxCodeRate as e
  on a.TaxCode = e.TaxCode
 and e.VATConditionType = 'JOUG'
 
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.LedgerGLLineItem,
    a.AccountingDocumentItem,
    a.DocumentIsRevered,
    a.ReveredDocument,
    a.TaxCode,
    a.FinancialAccountType,
    a.OffsettingAccount,
    a.GLAccount,
    a.AccountingDocumentType,
    a.ReferenceDocument,
    a.ProfitCenter,
    a.taxable_value,
    a.quantity,
    a.BaseUnit,
    b.ConditionRateRatio as igst_rate,
    
    
//        cast( cast( cast(a.taxable_value as abap.fltp) *  cast(b.ConditionRateRatio as abap.fltp) as abap.fltp) / 
//          cast( 100.00 as abap.fltp) as abap.dec(20,3)  ) as igst_amount,

     cast( round( (   cast( a.taxable_value as abap.dec(18,3) )
          * cast( b.ConditionRateRatio as abap.dec(5,2) )) / 100, 2)
    as abap.dec(18,2)
) as igst_amount ,
          
    c.ConditionRateRatio as cgst_rate,
//    cast( cast( cast(a.taxable_value as abap.fltp) *  cast(c.ConditionRateRatio as abap.fltp) as abap.fltp) / 
//          cast( 100.00 as abap.fltp) as abap.dec(20,3)  ) as cgst_amount,
    
cast( round( (   cast( a.taxable_value as abap.dec(18,3) )
          * cast( c.ConditionRateRatio as abap.dec(5,2) )) / 100, 2)
    as abap.dec(18,2)
) as cgst_amount,


    
    
    d.ConditionRateRatio as sgst_rate,
//    cast( cast( cast(a.taxable_value as abap.fltp) *  cast(d.ConditionRateRatio as abap.fltp) as abap.fltp) / 
//          cast( 100.00 as abap.fltp) as abap.dec(20,3)  ) as sgst_amount,

 cast( round( (   cast( a.taxable_value as abap.dec(18,3) )
          * cast( c.ConditionRateRatio as abap.dec(5,2) )) / 100, 2)
    as abap.dec(18,2)
) as sgst_amount,
          
    e.ConditionRateRatio as ugst_rate,
    cast( cast( cast(a.taxable_value as abap.fltp) *  cast(e.ConditionRateRatio as abap.fltp) as abap.fltp) / 
          cast( 100.00 as abap.fltp) as abap.dec(20,3)  ) as ugst_amount
    
}

//  as select distinct from I_JournalEntryItem    as a
//    left outer join       ZFI_GSTR1_REPORT_UGST as b on  a.AccountingDocument = b.AccountingDocument
//                                                     and a.CompanyCode        = b.CompanyCode
//                                                     and a.FiscalYear         = b.FiscalYear
//                                                     and a.LedgerGLLineItem   = b.LedgerGLLineItem
//    left outer join       ZFI_GSTR1_REPORT_SGST as c on  a.AccountingDocument = c.AccountingDocument
//                                                     and a.CompanyCode        = c.CompanyCode
//                                                     and a.FiscalYear         = c.FiscalYear
//                                                     and a.LedgerGLLineItem   = c.LedgerGLLineItem
//    left outer join       ZFI_GSTR1_REPORT_CGST as d on  a.AccountingDocument = d.AccountingDocument
//                                                     and a.CompanyCode        = d.CompanyCode
//                                                     and a.FiscalYear         = d.FiscalYear
//                                                     and a.LedgerGLLineItem   = d.LedgerGLLineItem
//    left outer join       ZFI_GSTR1_REPORT_IGST as e on  a.AccountingDocument = e.AccountingDocument
//                                                     and a.CompanyCode        = e.CompanyCode
//                                                     and a.FiscalYear         = e.FiscalYear
//                                                     and a.LedgerGLLineItem   = e.LedgerGLLineItem
//    left outer join       ZFI_GSTR1_REPORT_TCS  as f on  a.AccountingDocument = f.AccountingDocument
//                                                     and a.CompanyCode        = f.CompanyCode
//                                                     and a.FiscalYear         = f.FiscalYear
//                                                     and a.LedgerGLLineItem   = f.LedgerGLLineItem
//{
//  key a.AccountingDocument,
//      a.LedgerGLLineItem,
//      a.CompanyCode,
//      a.FiscalYear,
//      b.ugst_amount,
//      c.sgst_amount,
//      d.cgst_amount,
//      e.igst_amount,
//      sum( cast( a.AmountInBalanceTransacCrcy as abap.dec(30,2)) ) as taxable_value,
//      f.tcs_amount
//}
//where
//       a.FinancialAccountType         = 'S'
//  and  a.Ledger                       = '0L'
//  //    and a.DebitCreditCode = 'H'
//  and  a.TransactionTypeDetermination = ' '
//  and(
//       a.AccountingDocumentType       = 'DR'
//    or a.AccountingDocumentType       = 'RV'
//    or a.AccountingDocumentType       = 'DG'
//  )
////  and (a.GLAccount <> '0050300106' 
////  or a.GLAccount <> '0022200064')
//  
//group by
//  a.AccountingDocument,
//  a.LedgerGLLineItem,
//  a.CompanyCode,
//  a.FiscalYear,
//  b.ugst_amount,
//  c.sgst_amount,
//  d.cgst_amount,
//  e.igst_amount,
//  f.tcs_amount
