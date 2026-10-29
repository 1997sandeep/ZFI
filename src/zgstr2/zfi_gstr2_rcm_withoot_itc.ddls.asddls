@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for rcm without itc amt'
@Metadata.ignorePropagatedAnnotations: true
define view entity zfi_gstr2_rcm_withoot_itc as select  from I_JournalEntryItem as a
left outer join I_TaxCodeRate as b on a.TaxCode = b.TaxCode
                               and  b.VATConditionType = 'JICN'
left outer join I_OperationalAcctgDocItem  as c on a.AccountingDocument = c.AccountingDocument 
                                            and  a.AccountingDocumentItem = c.AccountingDocumentItem 
                                            and a.CompanyCode            = c.CompanyCode
                                            and a.FiscalYear            = c.FiscalYear
                                            
left outer join I_TaxCodeRate as bb on a.TaxCode = bb.TaxCode
                               and  bb.VATConditionType = 'JIIN'  
                               
left outer join I_TaxCodeRate as KK on a.TaxCode = b.TaxCode
                               and  KK.VATConditionType = 'JISN'                                

left outer join I_TaxCodeRate as bbb on a.TaxCode = bbb.TaxCode
                               and  bbb.VATConditionType = 'JIUN'                                                                             
{
    key a.AccountingDocument,
//    key a.AccountingDocumentItem,
    key a.FiscalYear,
    key a.CompanyCode,
    a.TransactionCurrency,
   
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.AmountInTransactionCurrency,
    
    b.ConditionRateRatioUnit,

    @Semantics.quantity.unitOfMeasure: 'ConditionRateRatioUnit'
    
    case when b.TaxCode between 'RM' and 'RZ' then
        cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( b.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
    end as rcm_cgst_without_itc,
    
    
    
    case when KK.TaxCode between 'RM' and 'RZ' then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( KK.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
   end   as rcm_Sgst_without_itc,
   
   
   
   
     case when bb.TaxCode between 'RM' and 'RZ' then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( bb.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
   end   as rcm_igst_without_itc,
   
   
   
   
      case when bbb.TaxCode between 'RM' and 'RZ' then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( bbb.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
   end   as rcm_ugst_without_itc,
   
   
   
   case when b.TaxCode between 'NA' and 'NR' then
        cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( b.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
    end as cgst_No_credit,
    
    
    
    case when b.TaxCode between 'NA' and 'NR' then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( b.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else  null
   end   as Sgst_no_credit,
   
   
   
   
     case when bb.TaxCode between 'NA' and 'NR'   then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( bb.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
   end   as igst_no_credit,
   
   
   
   
       case when bbb.TaxCode between 'NA' and 'NR' then 
       cast( coalesce( cast(c.OriginalTaxBaseAmount as abap.dec(13,2)), 0 ) as abap.dec(13,2)) *
        cast( coalesce( bbb.ConditionRateRatio, cast(0 as abap.dec(5,2)) ) as abap.dec(13,2)) / 100
        else null
   end   as ugst_no_credit
   
   
   
   
   
   
     
 }  where
  c.DebitCreditCode = 'S'
      and 
      a.Ledger = '0L'
// where b.VATConditionType = 'JICN'
//   and (b.TaxCode = 'RM' or b.TaxCode = 'RZ' ) 

