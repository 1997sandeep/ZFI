@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZFI_GSTR1_REPORT1
  as select distinct from ZGSTR1_BASIC_DATA              as a

    left outer join       I_OperationalAcctgDocItem      as bb    on  a.CompanyCode           = bb.CompanyCode
                                                                  and a.FiscalYear            = bb.FiscalYear
                                                                  and a.AccountingDocument    = bb.AccountingDocument
                                                                  and bb.FinancialAccountType = 'D'
    left outer join       I_Customer      as cust    on  cust.Customer          = bb.Customer
                                                               
                                                                  
    left outer join       ZFI_GSTR1_REPORT_TAX_VAL       as b     on  a.CompanyCode        = b.CompanyCode
                                                                  and a.FiscalYear         = b.FiscalYear
                                                                  and a.AccountingDocument = b.AccountingDocument
    left outer join I_JournalEntryItem as pro on                    pro.CompanyCode           = b.CompanyCode
                                                                  and pro.FiscalYear            = b.FiscalYear
                                                                  and pro.AccountingDocument    = b.AccountingDocument
                                                                  and pro.LedgerGLLineItem = b.LedgerGLLineItem
                                                                  and pro.Ledger = '0L'                                                             
    left outer join       ZFI_GSTR1_REPORT1_CUSTOMER     as ab    on  b.CompanyCode        = ab.CompanyCode
                                                                  and b.FiscalYear         = ab.FiscalYear
                                                                  and b.AccountingDocument = ab.AccountingDocument
    left outer join       I_GLAccountText                as c     on b.GLAccount = c.GLAccount
    left outer join       ZFI_GSTR1_REP_CUST_GSTIN_FINAL as d     on  b.AccountingDocument = d.AccountingDocument
                                                                  and b.CompanyCode        = d.CompanyCode
                                                                  and b.FiscalYear         = d.FiscalYear
    left outer join       I_OperationalAcctgDocItem      as e     on  b.AccountingDocument   = e.AccountingDocument
                                                                  and a.CompanyCode          = e.CompanyCode
                                                                  and a.FiscalYear           = e.FiscalYear
                                                                  and e.FinancialAccountType = 'D'
    left outer join       I_BusinessPlaceVH              as f     on e.BusinessPlace = f.BusinessPlace
    left outer join       I_IN_BusinessPlaceTaxDetail    as g     on e.BusinessPlace = g.BusinessPlace
    left outer join       I_AccountingDocumentTypeText   as h     on b.AccountingDocumentType = h.AccountingDocumentType
    left outer join       I_TaxCodeText                  as i     on b.TaxCode = i.TaxCode
    left outer join       ZFI_GSTR1_REPORT_TCS           as j     on  b.CompanyCode        = j.CompanyCode
                                                                  and b.FiscalYear         = j.FiscalYear
                                                                  and b.AccountingDocument = j.AccountingDocument
                                                                  and b.LedgerGLLineItem   = j.LedgerGLLineItem
    left outer join       ZFI_GSTR1_REPORT_HSN_CODE      as o     on  b.CompanyCode        = o.CompanyCode
                                                                  and b.FiscalYear         = o.FiscalYear
                                                                  and b.AccountingDocument = o.AccountingDocument
                                                                  and b.LedgerGLLineItem   = o.LedgerGLLineItem
    left outer join       I_ProfitCenterText             as p     on b.ProfitCenter = p.ProfitCenter
    left outer join       ZFI_GSTR1_REPORT_INV_VAL       as r     on  b.CompanyCode        = r.CompanyCode
                                                                  and b.FiscalYear         = r.FiscalYear
                                                                  and b.AccountingDocument = r.AccountingDocument
                                                                  and b.LedgerGLLineItem   = r.LedgerGLLineItem
    left outer join       ZFI_GSTR1_REPORT_UOM           as s     on  b.CompanyCode        = s.CompanyCode
                                                                  and b.FiscalYear         = s.FiscalYear
                                                                  and b.AccountingDocument = s.AccountingDocument
                                                                  and b.LedgerGLLineItem   = s.LedgerGLLineItem
    left outer join       ZFI_GSTR1_REPORT_INV_REF_NO    as t     on  b.CompanyCode        = t.CompanyCode
                                                                  and b.FiscalYear         = t.FiscalYear
                                                                  and b.AccountingDocument = t.AccountingDocument
    left outer join       I_Customer                     as u     on ab.Customer = u.Customer
    left outer join       ZFI_GSTR1_REPORT_ROUNFOFF_AMT  as v     on  b.CompanyCode        = v.CompanyCode
                                                                  and b.FiscalYear         = v.FiscalYear
                                                                  and b.AccountingDocument = v.AccountingDocument
    left outer join       ZFI_GSTR_REPORT_CREATED_BY     as w     on  b.CompanyCode        = w.CompanyCode
                                                                  and b.FiscalYear         = w.FiscalYear
                                                                  and b.AccountingDocument = w.AccountingDocument
    left outer join       ZFI_GSTR_REPORT_SALES_INVNO    as x     on  b.CompanyCode        = x.CompanyCode
                                                                  and b.FiscalYear         = x.FiscalYear
                                                                  and b.AccountingDocument = x.AccountingDocument
    left outer join       ZTCS_AMT_CDS                   as shub  on  shub.AccountingDocument = e.AccountingDocument
                                                                  and shub.FiscalYear         = e.FiscalYear
                                                                  and shub.CompanyCode        = e.CompanyCode
                                                                  and shub.LedgerGLLineItem   = b.LedgerGLLineItem
    left outer join       zfi_ledger_cds                 as kkk   on  kkk.AccountingDocument = b.AccountingDocument
                                                                  and kkk.FiscalYear         = b.FiscalYear
                                                                  and kkk.CompanyCode        = b.CompanyCode
    left outer join       zfi_gstr1_round_of_cds         as shub1 on  shub1.AccountingDocument = b.AccountingDocument
                                                                  and shub1.FiscalYear         = b.FiscalYear
                                                                  and shub1.CompanyCode        = b.CompanyCode
       left outer join ZFI_GSTR2_HSN_SAC            as n on  bb.AccountingDocument = n.AccountingDocument
                                                      and bb.FiscalYear         = n.FiscalYear
                                                      and bb.CompanyCode        = n.CompanyCode
        left outer join I_ProductDescription as des on pro.Product = des.Product                                                                                                            

{

          @Consumption.valueHelpDefinition: [{ entity: {name: 'ZINVOICE_F4',   element: 'AccountingDocument'
          } }]

  key     b.AccountingDocument,
  key     bb.BillingDocument,
  key pro.Product,
  key des.ProductDescription,
   key             b.LedgerGLLineItem,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZFI_COMPANY_CODE_F4',element: 'CompanyCode'
          } }]
  key     b.CompanyCode,
  key     b.FiscalYear,
  key     case
      when a.ReversalReferenceDocument is initial then 'Invoiced'
      else 'Cancelled'end                              as doc_status,
  key     a.AccountingDocumentType,
  key     a.ReversalReferenceDocument                as org_tax,
  key     h.AccountingDocumentTypeName,
  key     a.DocumentDate,
  key     a.PostingDate,
  key     b.DocumentIsRevered,
  key     b.ReveredDocument,
  key     b.OffsettingAccount,
  key     b.GLAccount,
  key     c.GLAccountLongName,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZFI_CUSTOMER_F4', element: 'Customer'
          } }]
  key     ab.Customer,
  key     u.CustomerName                             as customer_name,
  key     d.customer_gstin,
  key case cust.CustomerAccountGroup
  when 'Y001' then 'Domestic'
  when 'Y002' then 'Domestic'
  when 'Y003' then 'Domestic'
  when 'Y004' then 'Domestic'
  when 'Y005' then 'Export'
  when 'Y006' then 'Export'
  else '' end as cust_grp,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZFI_BUSINESS_PLACE_F4',element: 'BusinessPlace'
          }   }]
  key o.HSNNature,         
  key     e.BusinessPlace,
  key     f.BusinessPlaceDescription,
  key     g.IN_GSTIdentificationNumber,
  key     d.Region,
  key     case
       when b.TaxCode between 'RA' and 'RX'
       then 'Yes'
       else 'No'
       end                                           as supply_attract_rev,
  key     b.TaxCode,
  key     i.TaxCodeName,
  key     cast( b.cgst_rate as abap.dec( 12, 2 )) as cgst_rate,
  key     cast(b.sgst_rate  as abap.dec( 12, 2 )) as sgst_rate,
  key     cast( b.igst_rate  as abap.dec( 12, 2 )) as igst_rate,
//  key     b.ugst_rate,
  key     b.taxable_value,
  key     v.roundoff_amt,
  key     abs(b.cgst_amount)                         as cgst_amount,
  key     abs(b.sgst_amount)                         as sgst_amount,
  key     abs(b.igst_amount)                         as igst_amount,
//  key     abs(b.ugst_amount)                         as ugst_amount,
  key     cast(abs(shub.TCS_AMT) as  abap.dec(13,2)) as tcs_amount,
  key     j.DistributionChannel,
  key     j.Division,
  key     abs(r.invoice_value)                       as invoice_value,
  key     o.hsn_code,
  key     b.ProfitCenter,
  key     p.ProfitCenterLongName,
  key     d.gstin_status,
//  key     b.quantity,
//  key     s.uom,
  key     t.InvoiceNo,
  key     w.PersonFullName,
  key     x.DocumentReferenceID                      as Sales_Inv_No,
  key     case
          when b.LedgerGLLineItem = kkk.line_min
          then shub1.round_off_amt
      end                                            as round_off_amt


}
where
       b.AccountingDocument     is not null
  and(
       a.AccountingDocumentType =  'DR'
    or a.AccountingDocumentType =  'RV'
    or a.AccountingDocumentType =  'DG'
  )

  and
       b.GLAccount              != '0040200059'
  and  b.GLAccount              != '0050200028'
  and  b.GLAccount              != '0050300106'
  and  b.GLAccount              != '0050500054'
