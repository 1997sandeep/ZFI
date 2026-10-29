@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE - Doc to Clearing Doc Link'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_MRN_LINK

  as select distinct from I_AccountingDocumentJournal(
       P_Language: $session.system_language
     )

{
  key CompanyCode                as CompanyCode,

  key FiscalYear                 as FiscalYear,

  key AccountingDocument         as AccountingDocument,

  key ClearingAccountingDocument as ClearingDocument,

  key ClearingDocFiscalYear      as ClearingDocFiscalYear
}

where Ledger                     = '0L'
  and ClearingAccountingDocument <> ''
