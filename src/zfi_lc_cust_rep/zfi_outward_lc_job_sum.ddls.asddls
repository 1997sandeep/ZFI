@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Outward LC Job Billing Summary'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_OUTWARD_LC_JOB_SUM 
as select from ZFI_OUTWARD_LC_JOBDETAIL as job
{
  key job.LCNumber as LCNumber,

      sum(
        cast( job.GrossTotal as abap.dec(23,2) )
      ) as BilledUnderLC
}
group by
  job.LCNumber
