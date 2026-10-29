@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 Report (Optimized)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZFI_GSTR2_REPORT1
  as select distinct from ZFI_GSTR2_REPORT2 as a
 association  [0..1] to ZFI_GSTR2_REPORT_TAX_VAL   as _tax on  a.AccountingDocument = _tax.AccountingDocument
                                                           and a.CompanyCode        = _tax.CompanyCode
                                                           and a.FiscalYear         = _tax.FiscalYear
                                                           and a.LedgerGLLineItem   = _tax.LedgerGLLineItem

 association  [0..1] to ZFI_GSTR2_REP_INVOICE_VAL  as _inv on  a.AccountingDocument = _inv.AccountingDocument
                                                           and a.CompanyCode        = _inv.CompanyCode
                                                           and a.FiscalYear         = _inv.FiscalYear
                                                           and a.LedgerGLLineItem   = _inv.LedgerGLLineItem

association  [0..1] to ZFI_GSTR1_REPORT_UOM       as _uom on  a.AccountingDocument = _uom.AccountingDocument
                                                           and a.CompanyCode        = _uom.CompanyCode
                                                           and a.FiscalYear         = _uom.FiscalYear
                                                           and a.LedgerGLLineItem   = _uom.LedgerGLLineItem


association  [0..1] to ZFI_GSTR2_REPORT_SUPPLIER  as _sup on  a.AccountingDocument = _sup.AccountingDocument
                                                           and a.CompanyCode        = _sup.CompanyCode
                                                           and a.FiscalYear         = _sup.FiscalYear

 association  [0..1] to ZFI_GSTR2_REPORT_PO        as _po  on  a.AccountingDocument = _po.AccountingDocument
                                                           and a.CompanyCode        = _po.CompanyCode
                                                           and a.FiscalYear         = _po.FiscalYear

 association  [0..1] to ZFI_GSTR2_REPORT_HSN_CODE  as _hsn on  a.AccountingDocument = _hsn.AccountingDocument
                                                           and a.CompanyCode        = _hsn.CompanyCode
                                                           and a.FiscalYear         = _hsn.FiscalYear
                                                           and a.LedgerGLLineItem   = _hsn.LedgerGLLineItem

association  [0..1] to ZFI_GSTR_REPORT_CREATED_BY as _usr on  a.AccountingDocument = _usr.AccountingDocument
                                                           and a.CompanyCode        = _usr.CompanyCode
                                                           and a.FiscalYear         = _usr.FiscalYear

association  [0..1] to zfi_gstr2_rcm_withoot_itc      as shub on a.AccountingDocument   = shub.AccountingDocument
                                                             and a.CompanyCode         = shub.CompanyCode
                                                             and a.FiscalYear          = shub.FiscalYear 
association  [0..1] to I_ProductDescription      as prodes on   a.Product = prodes.Product
                                                             
                                                                                                                                                                                                                                                                                                     
{
  key a.AccountingDocument,
  key a.CompanyCode,
  key a.FiscalYear,
  key _tax.LedgerGLLineItem,
      a.Product,
      prodes.ProductDescription,
      a.DocumentIsRevered,
      a.ReveredDocument,
      a.BusinessPlace,
      a.bp_name,
      a.bp_gstin,
      a.expense_gl,
      a.expense_gl_name,
      a.invoice_ref_no,
      a.document_type,
      a.DocumentDate,
      a.PostingDate,
      a.TaxCode,
      a.TaxCodeName,
      a.taxable_value   as taxable_amount,
      a.ProfitCenter,
      a.ProfitCenterLongName,
      a.Quantity,

      _sup.Supplier,
      _sup.SupplierName as SupplierFullName,
      _sup.supplier_gstin,
      _sup.supplier_city,
      _sup.supplier_reg,
      a.supply_attract_rev,

      _po.PurchasingDocument,
      _inv.invoice_value,
      _hsn.hsn_code     as IN_HSNOrSACCode,
      _usr.PersonFullName,

      cast( _tax.igst_rate as abap.dec( 10,2 ) ) as igst_rate,
      cast( _tax.cgst_rate as abap.dec( 10,2 ) ) as cgst_rate,
      cast( _tax.sgst_rate as abap.dec( 10,2 ) ) as sgst_rate,
       cast( _tax.ugst_rate as abap.dec( 10,2 ) ) as ugst_rate ,
      cast(a.igst as abap.dec(13,2)) as  igst_amount,
      cast(a.cgst as abap.dec(13,2)) as  cgst_amount,
      cast(a.sgst as abap.dec(13,2)) as sgst_amount,
      cast(a.ugst as abap.dec(13,2)) as  ugst_amount,
//      _tax.ugst_rate,
//      _tax.igst_amount,
//      _tax.cgst_amount,
//      _tax.sgst_amount,
//      _tax.ugst_amount,
      _tax.rcm_igst_with_itc,
      _tax.rcm_cgst_with_itc,
      _tax.rcm_sgst_with_itc,
      _tax.rcm_ugst_with_itc,
    
    
      cast(shub.rcm_cgst_without_itc as abap.dec(13,2))   as rcm_cgst_without_itc,
      cast(shub.rcm_Sgst_without_itc  as abap.dec(13,2)) as rcm_sgst_without_itc ,
      cast(shub.rcm_igst_without_itc  as abap.dec(13,2)) as rcm_igst_without_itc ,
      cast(shub.rcm_ugst_without_itc as abap.dec(13,2))   as rcm_ugst_without_itc,
     cast( shub.cgst_No_credit as abap.dec(13,2)) as  cgst_no_credit,
      cast(shub.Sgst_no_credit as abap.dec(13,2)) as  sgst_no_credit,
     cast( shub.igst_no_credit as abap.dec(13,2)) as igst_no_credit,
      cast(shub.ugst_no_credit as abap.dec(13,2)) as ugst_no_credit,
      
      
      
      


      case
        when _sup.supplier_gstin is null or _sup.supplier_gstin = ''
        then 'GST NOT REGISTERED'
        else 'GST REGISTERED'
      end               as gstin_status,

      _uom.uom


}
