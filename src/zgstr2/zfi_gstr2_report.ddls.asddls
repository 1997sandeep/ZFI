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
define  view entity ZFI_GSTR2_REPORT 
 as select distinct from ZFI_GSTR2_REPORT1
{


    @Consumption.valueHelpDefinition: [{
    entity: {
        name: 'ZINVOICE_F4',
        element: 'AccountingDocument'
    }
}]
   key AccountingDocument,
   @Consumption.valueHelpDefinition: [{
    entity: {
        name: 'ZFI_COMPANY_CODE_F4',
        element: 'CompanyCode'
    }
}]
   key CompanyCode,
   key FiscalYear,
   LedgerGLLineItem,
   @Consumption.valueHelpDefinition: [{
    entity: {
        name: 'ZFI_BUSINESS_PLACE_F4',
        element: 'BusinessPlace'
    }
}]
    BusinessPlace,
   bp_name,
   bp_gstin,
   DocumentIsRevered,
   ReveredDocument,
   expense_gl,
   expense_gl_name,
   invoice_ref_no,
   document_type,
   DocumentDate,
   PostingDate,
   @Consumption.valueHelpDefinition: [{
    entity: {
        name: 'ZFI_TNS_F4_SUPP',
        element: 'Supplier'
    }
}]
   Supplier,
   SupplierFullName,
   supplier_gstin,
   supplier_city,
   supplier_reg,
   supply_attract_rev,
   PurchasingDocument,
   TaxCode,
   TaxCodeName,
   taxable_amount,
   igst_rate,
   cgst_rate,
   sgst_rate,
   ugst_rate,
   igst_amount,
   cgst_amount,
   sgst_amount,
   ugst_amount,
   rcm_igst_with_itc,
   rcm_cgst_with_itc,
   rcm_sgst_with_itc,
   rcm_ugst_with_itc,
   rcm_igst_without_itc,
   rcm_cgst_without_itc,
   rcm_sgst_without_itc,
   rcm_ugst_without_itc,
   igst_no_credit,
   cgst_no_credit,
   sgst_no_credit,
   ugst_no_credit,
   invoice_value,
   IN_HSNOrSACCode,
   ProfitCenter,
   ProfitCenterLongName,
   gstin_status,
   Quantity,
   uom,
   PersonFullName,
   Product,
   ProductDescription
} 

