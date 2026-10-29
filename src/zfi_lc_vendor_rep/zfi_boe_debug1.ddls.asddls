@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOE Debug - BOE to MRN Link'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZFI_BOE_DEBUG1

  as select from zfi_ilc_boe as boe

    left outer join zfi_inward_lc as ilc
      on ilc.lc_number = boe.lc_number

    left outer join ZFI_MRN_GRN_FINAL as mrn
      on  mrn.CompanyCode  = ilc.company_code
      and mrn.BOEReference = boe.boe_ref_number

{
  key boe.boe_ref_number          as BoeRefNumber,

  key boe.lc_number               as LcNumber,

      ilc.company_code            as IlcCompanyCode,

      length( boe.boe_ref_number ) as BoeRefLen,

      /*-- MRN side: blank = join failed --*/

      mrn.BOEReference            as MrnBoeRef,

      mrn.CompanyCode             as MrnCompanyCode,

      mrn.DocumentNumber          as MrnDocumentNumber,

      length( mrn.DocumentNumber ) as MrnDocLen,

      cast(
        mrn.TotalAmount as abap.dec(23,2)
      )                           as MrnTotalAmount
}

where boe.boe_ref_number <> ''
