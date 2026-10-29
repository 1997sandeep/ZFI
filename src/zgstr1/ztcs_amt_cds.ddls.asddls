@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Tds Amount'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK", "CARDINALITY_CHECK" ]  } */
define view entity ZTCS_AMT_CDS as select distinct from I_JournalEntryItem as aa

association [0..1] to I_BillingDocumentItemPrcgElmnt as bb
    on  aa.ReferenceDocument    = bb.BillingDocument
    and aa.ReferenceDocumentItem = bb.BillingDocumentItem
    and bb.ConditionType         = 'ZTCS'    
{
    key aa.AccountingDocument,
//        aa.AccountingDocumentItem,
key aa.ReferenceDocumentItem,
   aa.ReferenceDocument,
   aa.LedgerGLLineItem,

        aa.FiscalYear,
        aa.CompanyCode,
        cast(bb.ConditionAmount as abap.dec(16,2)) as TCS_AMT
}
where aa.Ledger = '0L'
and aa.ReferenceDocumentItem  != '000000'



