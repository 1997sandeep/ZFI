@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer BG Project Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_CUSTOMER_BG_F4 
as select distinct from I_EnterpriseProject as Project
                                              
left outer join I_EnterpriseProjectElement as ProjectElement
on ProjectElement.ProjectInternalID = Project.ProjectInternalID
                                             
left outer join I_SalesOrderItem as SalesOrderItem
on SalesOrderItem.WBSElementInternalID = ProjectElement.WBSElementInternalID
               
left outer join I_SalesOrder as SalesOrder
on SalesOrder.SalesOrder = SalesOrderItem.SalesOrder
            
left outer join I_Customer as Customer
on Customer.Customer = SalesOrder.SoldToParty
                                
{             
  key Project.Project,
                      
      Project.ProjectInternalID,
                            
      SalesOrderItem.SalesOrder,
              
      SalesOrder.SoldToParty as BeneficiaryCode,

      Customer.CustomerName  as BeneficiaryName

}
where ProjectElement.WBSElementIsBillingElement = 'X'
and   SalesOrder.SoldToParty <> ''
