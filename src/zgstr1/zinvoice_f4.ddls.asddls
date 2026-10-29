@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZINVOICE_F4 as select from I_JournalEntryItem
{
    key AccountingDocument
}
group by AccountingDocument
