@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC BOE - Received Amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_LC_BOE_REC 
as select from ZFI_BOE_PAID_REF as ref
left outer join I_AccountingDocumentJournal(
                  P_Language: $session.system_language
                ) as acc2

      on  acc2.AccountingDocument = ref.ClearingAccountingDocument
      and acc2.CompanyCode        = ref.CompanyCode
      and acc2.FiscalYear         = ref.ClearingDocFiscalYear
      and acc2.PostingKey         = '09'
      and acc2.SpecialGLCode      = 'W'

{
  key ref.AccountingDocument as AccountingDocument,

  key ref.CompanyCode       as CompanyCode,

  key ref.FiscalYear        as FiscalYear,

      @Semantics.amount.currencyCode : 'CompanyCodeCurrency'

      sum(
        cast(
          acc2.CreditAmountInCoCodeCrcy
          as abap.dec(15,2)
        )
      ) as CreditAmount,

      @Semantics.amount.currencyCode : 'CompanyCodeCurrency'

      sum(
        cast(
          acc2.DebitAmountInCoCodeCrcy
          as abap.dec(15,2)
        )
      ) as DebitAmount,

      @Semantics.amount.currencyCode : 'CompanyCodeCurrency'

      (
        sum(
          cast(
            acc2.CreditAmountInCoCodeCrcy
            as abap.dec(15,2)
          )
        )
        -
        sum(
          cast(
            acc2.DebitAmountInCoCodeCrcy
            as abap.dec(15,2)
          )
        )
      ) as ReceivedAmount,
      
      max( acc2.PostingDate ) as ReceivedDate,

      acc2.CompanyCodeCurrency

}

group by

  ref.AccountingDocument,
  ref.CompanyCode,
  ref.FiscalYear,
  acc2.CompanyCodeCurrency
