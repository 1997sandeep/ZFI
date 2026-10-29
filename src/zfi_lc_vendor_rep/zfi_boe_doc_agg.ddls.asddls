@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE - MRN Document Aggregate'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_DOC_AGG

  as select from ZFI_BOE_MRN_LINK as link

    /* inner join: only clearing docs that really are BoE acceptances */
    /* the clearing doc fiscal year is still honoured here           */
    inner join ZFI_BOE_ACCEPT_AGG as accept
      on  accept.CompanyCode        = link.CompanyCode
      and accept.FiscalYear         = link.ClearingDocFiscalYear
      and accept.AccountingDocument = link.ClearingDocument

{
  key link.CompanyCode        as CompanyCode,

  key link.AccountingDocument as AccountingDocument,

      max( accept.AccountingDocument ) as AcceptanceDocument,

      cast(
        sum( accept.AcceptedAmount ) as abap.dec(23,2)
      )                              as AcceptedAmount,

      max( accept.PaymentDocument )  as PaymentDocument,

      cast(
        sum( accept.PaidAmount ) as abap.dec(23,2)
      )                              as PaidAmount,

      max( accept.PaymentDate )      as PaymentDate
}

group by
  link.CompanyCode,
  link.AccountingDocument
