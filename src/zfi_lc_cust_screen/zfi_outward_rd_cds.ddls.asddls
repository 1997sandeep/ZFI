@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC Required Documents'
@Metadata.ignorePropagatedAnnotations: true    
define root view entity ZFI_OUTWARD_RD_CDS 
as select from zfi_outward_rd       
{                              
    key zlcnumber        as Zlcnumber, 
    key zsl_number       as ZslNumber,     
    zdocumentdescription as Zdocumentdescription,
    created_by           as CreatedBy,     
    created_at           as CreatedAt,   
    last_changed_by      as LastChangedBy, 
    last_changed_at      as LastChangedAt
}
