@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inward LC Master Data'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_INWARD_LC_CDS
  as select from zfi_inward_lc
{
  key company_code        as CompanyCode,
  key lc_number           as LcNumber,
      lc_banknumber       as LcBankNumber,
      lc_type             as LcType,
      vendor_code         as VendorCode,
      vendor_name         as VendorName,
      issuing_bank        as IssuingBank,
      lc_currency         as LcCurrency,
      @Semantics.amount.currencyCode: 'LcCurrency'
      lc_amount           as LcAmount,
      amount_version      as AmountVersion,
      tolerance_percent   as TolerancePercent,
      @Semantics.amount.currencyCode: 'LcCurrency'
      tolerance_amount    as ToleranceAmount,
      @Semantics.amount.currencyCode: 'LcCurrency'
      total_lc_amount     as TotalLcAmount,
      lc_date             as LcDate,
      last_shipment_date  as LastShipmentDate,
      lsd_version         as LsdVersion,
      expiry_date         as ExpiryDate,
      ed_version          as EdVersion,
      lc_percent          as LcPercent,
      purchase_order      as PurchaseOrder,
      po_date             as PoDate,
      @Semantics.amount.currencyCode: 'LcCurrency'
      basic_po_amount     as BasicPoAmount,
      @Semantics.amount.currencyCode: 'LcCurrency'
      gst_amount          as GstAmount,
      @Semantics.amount.currencyCode: 'LcCurrency'
      total_po_amount     as TotalPoAmount,
      @Semantics.amount.currencyCode: 'LcCurrency'
      tds_amount          as TdsAmount,
      boe_due_period      as BoeDuePeriod,
      execution_status    as ExecutionStatus,
      issuance_status     as IssuanceStatus,
      @Semantics.amount.currencyCode: 'LcCurrency'
      short_closed_amount as ShortClosedAmount,
      remarks             as Remarks,
      commrate            as Commrate,
      commbasis           as Commbasis,
      commamount          as Commamount,
      lcmargin            as Lcmargin,
      lcmarginamt         as Lcmarginamt,
      lctenure            as Lctenure,
      zbankifsc           as Zbankifsc,
      zbankname           as Zbankname,
      zbankaddr           as Zbankaddr,
      zbankname1          as Zbankname1,
      zbankaddr1          as Zbankaddr1,
      zvendorbankifsc     as Zvendorbankifsc,
      zvendorbankname     as Zvendorbankname,
      zvendorbankaddr     as Zvendorbankaddr,
      zgstcommamt         as Zgstcommamt,
      ztotcommamt         as Ztotcommamt,
      zotherrate          as Zotherrate,
      zotheramount        as Zotheramount,
      pidate              as Pidate,
      pino                as Pino,
      zdms                as DMS,
      zfile               as FileNo,
      zmimetype           as MimeType,
      zfilename           as FileName,
      descrepancies       as Descrepancies,
      createdon           as Createdon,
      createdat           as Createdat,
      createdby           as Createdby,
      changedon           as Changedon,
      changedat           as Changedat,
      changedby           as Changedby,
      lastchanged         as Lastchanged
}
