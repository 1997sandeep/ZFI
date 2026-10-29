@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inward LC Required Documents'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_LC_REQ_DOC_CDS 
as select distinct from zfi_lc_req_doc
{
    key company_code     as CompanyCode,
    key lc_number        as LcNumber,
    key sl_number        as SlNumber,
    document_description as DocumentDescription,
    createdon            as Createdon,
    createdat            as Createdat,
    createdby            as Createdby,
    changedon            as Changedon,
    changedat            as Changedat,
    changedby            as Changedby,
    lastchanged          as Lastchanged
}
