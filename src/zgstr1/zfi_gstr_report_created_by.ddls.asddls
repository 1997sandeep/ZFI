@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR Report created by'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_GSTR_REPORT_CREATED_BY 
  as select from ZFI_GSTR_REPORT_CREATED_BY1 as a
left outer join I_BusinessUser as b
  on a.created_by = b.BusinessPartner

{
  key a.AccountingDocument,
  key a.CompanyCode,
  key a.FiscalYear,
  a.AccountingDocCreatedByUser,
  a.created_by,
  case 
  when b.PersonFullName is null
  then a.created_by
  else b.PersonFullName
  end as PersonFullName

}
group by
a.AccountingDocument,
a.CompanyCode,
a.FiscalYear,
a.AccountingDocCreatedByUser,
a.created_by,
b.PersonFullName
