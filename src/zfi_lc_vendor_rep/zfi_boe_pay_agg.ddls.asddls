@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE - Payment Document Aggregate'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_PAY_AGG

  as select from I_AccountingDocumentJournal(
       P_Language: $session.system_language
     )

{
  key CompanyCode        as CompanyCode,

  key FiscalYear         as FiscalYear,

  key AccountingDocument as AccountingDocument,

      /* Payment clears the acceptance -> debit side */
      cast(
        sum(
          cast( DebitAmountInCoCodeCrcy  as abap.dec(23,2) )
          -
          cast( CreditAmountInCoCodeCrcy as abap.dec(23,2) )
        )
        as abap.dec(23,2)
      )                  as PaidAmount,

      max( PostingDate ) as PaymentDate
}

where Ledger        = '0L'
  and SpecialGLCode = 'W'

group by
  CompanyCode,
  FiscalYear,
  AccountingDocument
