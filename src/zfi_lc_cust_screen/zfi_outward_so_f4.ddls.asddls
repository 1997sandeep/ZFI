@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_SO_F4 
as select from  I_SalesOrder        as a
left outer join I_SalesDocument     as b on
a.SalesOrder = b.SalesDocument
left outer join I_SalesDocumentItem as c on
a.SalesOrder = c.SalesDocument
{                                                               
    key a.SalesOrder,     
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        b.TotalNetAmount   as OrderAmtBasic,
        b.TransactionCurrency,      
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum( c.TaxAmount ) as GSTAmount,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        b.TotalNetAmount + sum( c.TaxAmount ) as OrderAmtIncludingGST
}                                 
group by                                   
    a.SalesOrder,          
    b.TotalNetAmount,           
    b.TransactionCurrency;
