@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Document'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_BILLING_DOC 
as select distinct from I_EnterpriseProject as Project
                                                                                                                
left outer join I_EnterpriseProjectElement  as WBSElement
on WBSElement.ProjectInternalID     = Project.ProjectInternalID
         
left outer join I_BillingDocumentItem       as BillingItem
on BillingItem.WBSElementInternalID = WBSElement.WBSElementInternalID
                                                                                    
left outer join I_BillingDocument           as Bill on
BillingItem.BillingDocument         = Bill.BillingDocument
                                                  
{                                    
  key BillingItem.BillingDocument           as BillingDocument,
                                                                       
      @Semantics.amount.currencyCode: 'Currency'
      Bill.TotalNetAmount                   as InvoiceAmt,
                                                              
      Bill.TransactionCurrency              as Currency,
                     
      Project.Project                       as ProjectID,
                                         
      Project.ProjectInternalID             as ProjectInternalID,
            
      WBSElement.WBSElementInternalID       as WBSElementInternalID,

      WBSElement.WBSElementIsBillingElement as WBSBillingElement
                  
}                                                      
where BillingItem.BillingDocument           <> ''
and   WBSElement.WBSElementIsBillingElement = 'X'
