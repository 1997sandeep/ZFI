@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE - Acceptance Document Aggregate'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_ACCEPT_AGG

  as select from I_AccountingDocumentJournal(
       P_Language: $session.system_language
     ) as acc

    /* acceptance -> payment link, already de-duplicated */
    left outer join ZFI_BOE_MRN_LINK as link
      on  link.CompanyCode        = acc.CompanyCode
      and link.FiscalYear         = acc.FiscalYear
      and link.AccountingDocument = acc.AccountingDocument

    left outer join ZFI_BOE_PAY_AGG as pay
      on  pay.CompanyCode        = link.CompanyCode
      and pay.FiscalYear         = link.ClearingDocFiscalYear
      and pay.AccountingDocument = link.ClearingDocument

{
  key acc.CompanyCode        as CompanyCode,

  key acc.FiscalYear         as FiscalYear,

  key acc.AccountingDocument as AccountingDocument,

      /* Acceptance posts as credit on the BoE special GL */
      cast(
        sum(
          cast( acc.CreditAmountInCoCodeCrcy as abap.dec(23,2) )
          -
          cast( acc.DebitAmountInCoCodeCrcy  as abap.dec(23,2) )
        )
        as abap.dec(23,2)
      )                      as AcceptedAmount,

      max( link.ClearingDocument ) as PaymentDocument,

      cast(
        max( pay.PaidAmount ) as abap.dec(23,2)
      )                      as PaidAmount,

      max( pay.PaymentDate ) as PaymentDate
}

where acc.Ledger        = '0L'
  and acc.PostingKey    = '39'
  and acc.SpecialGLCode = 'W'

group by
  acc.CompanyCode,
  acc.FiscalYear,
  acc.AccountingDocument
