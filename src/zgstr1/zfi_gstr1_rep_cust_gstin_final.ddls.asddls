@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report Customer GSTIN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REP_CUST_GSTIN_FINAL 
 as select distinct from ZFI_GSTR1_REP_CUST_GSTIN
{
    key AccountingDocument,
    CompanyCode,
    FiscalYear,
    Region,
    gstin_status,
    BillingDocument,
    SalesDocument,
    PartnerFunction,
    customer_gstin
} where Region <> ' '
    and customer_gstin <> ' '

group by AccountingDocument,
    CompanyCode,
    FiscalYear,
    Region,
    gstin_status,
    BillingDocument,
    SalesDocument,
    PartnerFunction,
    customer_gstin

