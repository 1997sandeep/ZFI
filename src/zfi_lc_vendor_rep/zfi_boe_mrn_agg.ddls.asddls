@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE - MRN Aggregate by BOE Reference'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_MRN_AGG

  as select from ZFI_MRN_GRN_FINAL as mrn

    left outer join ZFI_BOE_DOC_AGG as doc
      on  doc.CompanyCode        = mrn.CompanyCode
      and doc.AccountingDocument = mrn.DocumentNumber

{
  key mrn.CompanyCode  as CompanyCode,

  key mrn.BOEReference as BOEReference,

      cast(
        sum( cast( mrn.TotalAmount as abap.dec(23,2) ) )
        as abap.dec(23,2)
      )                as BillAmount,

      max( doc.AcceptanceDocument ) as AcceptanceDocument,

      cast(
        sum( doc.AcceptedAmount ) as abap.dec(23,2)
      )                as AcceptedAmount,

      max( doc.PaymentDocument )    as PaymentDocument,

      cast(
        sum( doc.PaidAmount ) as abap.dec(23,2)
      )                as PaidAmount,

      max( doc.PaymentDate )        as PaymentDate
}

where mrn.BOEReference <> ''

group by
  mrn.CompanyCode,
  mrn.BOEReference
