@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Net Amount F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_NETAMT_F4 
as select distinct from I_PurchaseOrderAPI01 as A
left outer join I_PurchaseOrderItemAPI01     as PO
on  A.PurchaseOrder      = PO.PurchaseOrder
                     
left outer join I_PurOrdPricingElementAPI01  as PR
on  PR.PurchaseOrder     = PO.PurchaseOrder
and PR.ConditionType     = 'ZJEX'
       
left outer join I_Supplier as SUP
on  A.Supplier           = SUP.Supplier
                                                       
{                                                           
  key A.PurchaseOrder as PONo,   
      A.CreationDate  as PODate,
      SUP.Supplier    as Vendor,
      PO.PurchaseOrderItem,            
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PO.NetAmount        as BasicPoAmt,
      PO.DocumentCurrency,         
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      PR.ConditionAmount  as GSTamt,
      // Total PO Amount                
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast( PO.NetAmount as abap.decfloat34 )
      +                                                             
      cast( PR.ConditionAmount as abap.decfloat34 )
      as TotalPOAmount,               
                                         
      @Semantics.amount.currencyCode: 'TransactionCurrency'                                                                                       
      cast( PO.NetAmount as abap.decfloat34 )
      *                                         
      cast( '0.001' as abap.decfloat34 )         
      as TDSAmount,        
      PR.TransactionCurrency

}
