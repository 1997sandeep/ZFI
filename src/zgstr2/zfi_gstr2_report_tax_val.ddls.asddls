@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report GST Values'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_GSTR2_REPORT_TAX_VAL
  as select from    ZFI_GSTR2_REPORT2 as a
    left outer join I_TaxCodeRate     as b on  a.TaxCode          = b.TaxCode
                                           and b.VATConditionType = 'JICG'
    left outer join I_TaxCodeRate     as c on  a.TaxCode          = c.TaxCode
                                           and c.VATConditionType = 'JISG'
    left outer join I_TaxCodeRate     as d on  a.TaxCode          = d.TaxCode
                                           and d.VATConditionType = 'JIIG'
    left outer join I_TaxCodeRate     as e on  a.TaxCode          = e.TaxCode
                                           and e.VATConditionType = 'JIUG'
    left outer join I_TaxCodeRate     as f //RCM CGST with ITC
                                           on  a.TaxCode            = f.TaxCode
                                           and f.VATConditionType   = 'JICR'
                                           and f.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as g //RCM SGST with ITC
                                           on  a.TaxCode            = g.TaxCode
                                           and g.VATConditionType   = 'JISR'
                                           and g.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as h //RCM IGST with ITC
                                           on  a.TaxCode            = h.TaxCode
                                           and h.VATConditionType   = 'JIIR'
                                           and h.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as i //RCM UGST with ITC
                                           on  a.TaxCode            = i.TaxCode
                                           and i.VATConditionType   = 'JIUR'
                                           and i.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as j //RCM CGST without ITC
                                           on  a.TaxCode            = j.TaxCode
                                           and j.VATConditionType   = 'JICN'
                                           and j.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as k //RCM SGST without ITC
                                           on  a.TaxCode            = k.TaxCode
                                           and k.VATConditionType   = 'JISN'
                                           and k.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as l //RCM IGST without ITC
                                           on  a.TaxCode            = l.TaxCode
                                           and l.VATConditionType   = 'JIIN'
                                           and l.ConditionRateRatio > 1
    left outer join I_TaxCodeRate     as m //RCM UGST without ITC
                                           on  a.TaxCode            = m.TaxCode
                                           and m.VATConditionType   = 'JIUN'
                                           and m.ConditionRateRatio > 1
{
  key a.AccountingDocument,
  key a.CompanyCode,
  key a.FiscalYear,
  key a.LedgerGLLineItem,
      a.taxable_value,
      a.TaxCode,
      b.ConditionRateRatio                                  as cgst_rate,
      c.ConditionRateRatio                                  as sgst_rate,
      d.ConditionRateRatio                                  as igst_rate,
      e.ConditionRateRatio                                  as ugst_rate,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(b.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as cgst_amount,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(c.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as sgst_amount,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(d.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as igst_amount,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(e.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as ugst_amount,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(f.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_cgst_with_itc,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(g.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_sgst_with_itc,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(h.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_igst_with_itc,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(i.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_ugst_with_itc,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(j.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_cgst_without_itc,


      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(k.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_sgst_without_itc,

      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(l.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_igst_without_itc,
//
      cast( cast( cast(a.taxable_value as abap.fltp) *  cast(m.ConditionRateRatio as abap.fltp) as abap.fltp) /
            cast( 100.00 as abap.fltp) as abap.dec(20,2)  ) as rcm_ugst_without_itc



}
group by
  a.AccountingDocument,
  a.CompanyCode,
  a.FiscalYear,
  a.LedgerGLLineItem,
  a.taxable_value,
  a.TaxCode,
  b.ConditionRateRatio,
  c.ConditionRateRatio,
  d.ConditionRateRatio,
  e.ConditionRateRatio,
  f.ConditionRateRatio,
  g.ConditionRateRatio,
  h.ConditionRateRatio,
  i.ConditionRateRatio,
  j.ConditionRateRatio,
  k.ConditionRateRatio,
  l.ConditionRateRatio,
  m.ConditionRateRatio
