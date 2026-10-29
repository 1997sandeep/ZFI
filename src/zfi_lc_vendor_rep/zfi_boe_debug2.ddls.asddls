@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE Debug - Journal Chain'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_DEBUG2

  as select from ZFI_MRN_GRN_FINAL as mrn

    /*-- HOP 1: MRN document ka har line item --*/

    left outer join I_AccountingDocumentJournal(
         P_Language: $session.system_language
       ) as acc1

      on  acc1.AccountingDocument = mrn.DocumentNumber
      and acc1.CompanyCode        = mrn.CompanyCode
      and acc1.Ledger             = '0L'

    /*-- HOP 2: clearing doc = acceptance doc --*/

    left outer join I_AccountingDocumentJournal(
         P_Language: $session.system_language
       ) as acc2

      on  acc2.AccountingDocument = acc1.ClearingAccountingDocument
      and acc2.CompanyCode        = acc1.CompanyCode
      and acc2.FiscalYear         = acc1.ClearingDocFiscalYear
      and acc2.Ledger             = '0L'

{
  key mrn.CompanyCode                 as CompanyCode,

  key mrn.BOEReference                as BoeReference,

  key mrn.DocumentNumber              as MrnDocument,

      /*-- HOP 1 columns --*/

      acc1.FiscalYear                 as Acc1Year,

      acc1.AccountingDocumentItem     as Acc1Item,

      acc1.PostingKey                 as Acc1PostingKey,

      acc1.SpecialGLCode              as Acc1SpecialGL,

      acc1.ClearingAccountingDocument as Acc1ClearingDoc,

      acc1.ClearingDocFiscalYear      as Acc1ClearingYear,

      /*-- HOP 2 columns --*/

      acc2.FiscalYear                 as Acc2Year,

      acc2.AccountingDocumentItem     as Acc2Item,

      acc2.PostingKey                 as Acc2PostingKey,

      acc2.SpecialGLCode              as Acc2SpecialGL,

      acc2.ClearingAccountingDocument as Acc2ClearingDoc,

      acc2.ClearingDocFiscalYear      as Acc2ClearingYear,

      /*-- CURR -> DEC cast, taaki currency reference na maange --*/

      cast(
        acc2.DebitAmountInCoCodeCrcy as abap.dec(23,2)
      )                               as Acc2Debit,

      cast(
        acc2.CreditAmountInCoCodeCrcy as abap.dec(23,2)
      )                               as Acc2Credit,

      acc2.PostingDate                as Acc2PostingDate
}

where mrn.BOEReference <> ''
