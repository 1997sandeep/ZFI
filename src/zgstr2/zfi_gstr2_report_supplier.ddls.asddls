@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report Supplier'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT_SUPPLIER
as select from I_JournalEntryItem as a
left outer join I_Supplier as b
  on a.Supplier = b.Supplier
{
    key a.AccountingDocument,
    key a.CompanyCode,
    key a.FiscalYear,
    a.Supplier,
    b.SupplierName,
    b.TaxNumber3 as supplier_gstin,
    b.CityName as supplier_city,
    b.Region as supplier_reg
} where a.Supplier <> ' '

group by a.AccountingDocument,
a.CompanyCode,
a.FiscalYear,
a.Supplier,
b.SupplierName,
    b.TaxNumber3,
    b.CityName,
    b.Region
