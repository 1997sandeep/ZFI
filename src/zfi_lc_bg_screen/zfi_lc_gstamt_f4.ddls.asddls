@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GST Amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_LC_GSTAMT_F4 
as select from I_PurOrdPricingElementAPI01 as Pricing
{
  key Pricing.PurchaseOrder     as PurchaseOrder,
      Pricing.ConditionType     as ConditionType,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Pricing.ConditionAmount   as GSTAmount,
      Pricing.TransactionCurrency 
}
where Pricing.ConditionType = 'ZJEX'
