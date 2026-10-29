@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report Customer GSTIN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR1_REP_CUST_GSTIN
 as select distinct from I_JournalEntryItem as a
 left outer join I_Customer as b
   on a.Customer = b.Customer
 left outer join I_OneTimeAccountCustomer as c
   on a.AccountingDocument = c.AccountingDocument
 left outer join I_BillingDocument as d
   on a.AccountingDocument = d.AccountingDocument
 left outer join I_SalesDocumentPartner as e
   on d.BillingDocument = e.SalesDocument
 left outer join I_PartnerFunction as f
   on e.PartnerFunction = f.PartnerFunction 
{
    key a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.Customer,
    b.Region,
    case  
    when b.TaxNumber3 is not initial or
         b.TaxNumber3 is not null
    then 'GST Registered'
    else 'GST Not Registered'
    end as gstin_status,
    d.BillingDocument,
    e.SalesDocument,
    f.PartnerFunction,
    case
    when b.IsOneTimeAccount is initial
    then b.TaxNumber3
    when b.IsOneTimeAccount is not initial
//     and a.AccountingDocumentType <> 'RV'
    then c.TaxID3
    end as customer_gstin
    
     
}

group by a.AccountingDocument,
    a.CompanyCode,
    a.FiscalYear,
    a.Customer,
    b.Region,
    b.TaxNumber3,
    d.BillingDocument,
    e.SalesDocument,
    f.PartnerFunction,
    b.IsOneTimeAccount,
    c.TaxID3



