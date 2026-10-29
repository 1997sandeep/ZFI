CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.
    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_inward_lc.

    CLASS-DATA mt_delete TYPE STANDARD TABLE OF zfi_inward_lc.
ENDCLASS.

CLASS lhc_ZFI_INWARD_LC_CDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS lc_prefix TYPE char3 VALUE 'AP-'.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zfi_inward_lc_cds RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zfi_inward_lc_cds RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE zfi_inward_lc_cds.

    METHODS update FOR MODIFY
       entities FOR UPDATE zfi_inward_lc_cds.

    METHODS delete FOR MODIFY
       keys FOR DELETE zfi_inward_lc_cds.

    METHODS read FOR READ
       keys FOR READ zfi_inward_lc_cds RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK zfi_inward_lc_cds.

ENDCLASS.

CLASS lhc_ZFI_INWARD_LC_CDS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

  DATA:
    wa_data       TYPE zfi_inward_lc,
    lv_max_num    TYPE numc4,
    lv_running    TYPE numc4,
    lv_fyear      TYPE numc4,
    lv_pattern    TYPE string,
    lv_max_lc     TYPE zfi_inward_lc-lc_number.

  LOOP AT entities INTO DATA(ls_entity).

    CLEAR:
      wa_data,
      lv_max_num,
      lv_running,
      lv_fyear,
      lv_pattern,
      lv_max_lc.

    wa_data-company_code        = ls_entity-CompanyCode.
    wa_data-lc_banknumber       = ls_entity-LcBankNumber.
    wa_data-lc_type             = ls_entity-LcType.
    wa_data-vendor_code         = ls_entity-VendorCode.
    wa_data-vendor_name         = ls_entity-VendorName.
    wa_data-issuing_bank        = ls_entity-IssuingBank.

    wa_data-lc_currency         = ls_entity-LcCurrency.
    wa_data-lc_amount           = ls_entity-LcAmount.

    wa_data-amount_version      = ls_entity-AmountVersion.

    wa_data-tolerance_percent   = ls_entity-TolerancePercent.
    wa_data-tolerance_amount    = ls_entity-ToleranceAmount.
    wa_data-total_lc_amount     = ls_entity-TotalLcAmount.

    wa_data-lc_date             = ls_entity-LcDate.
    wa_data-last_shipment_date  = ls_entity-LastShipmentDate.

    wa_data-lsd_version         = ls_entity-LsdVersion.

    wa_data-expiry_date         = ls_entity-ExpiryDate.
    wa_data-ed_version          = ls_entity-EdVersion.

    wa_data-lc_percent          = ls_entity-LcPercent.

    wa_data-purchase_order      = ls_entity-PurchaseOrder.
    wa_data-po_date             = ls_entity-PoDate.

    wa_data-basic_po_amount     = ls_entity-BasicPoAmount.
    wa_data-gst_amount          = ls_entity-GstAmount.
    wa_data-total_po_amount     = ls_entity-TotalPoAmount.

    wa_data-tds_amount          = ls_entity-TdsAmount.

    wa_data-boe_due_period      = ls_entity-BoeDuePeriod.

    wa_data-execution_status    = ls_entity-ExecutionStatus.
    wa_data-issuance_status     = ls_entity-IssuanceStatus.

    wa_data-short_closed_amount = ls_entity-ShortClosedAmount.

    wa_data-remarks             = ls_entity-Remarks.
    wa_data-descrepancies       = ls_entity-Descrepancies.
    wa_data-lcmargin = ls_entity-Lcmargin.
    wa_data-lcmarginamt = ls_entity-Lcmarginamt.
    wa_data-commamount = ls_entity-commamount.
    wa_data-commbasis = ls_entity-commbasis.
    wa_data-commrate = ls_entity-commrate.
    wa_data-lctenure = ls_entity-lctenure.

    wa_data-Ztotcommamt  = ls_entity-Ztotcommamt.
    wa_data-zgstcommamt = ls_entity-Zgstcommamt.
    wa_data-zbankifsc = ls_entity-Zbankifsc.
    wa_data-zbankname = ls_entity-Zbankname.
    wa_data-zbankaddr = ls_entity-zbankaddr.
    wa_data-zbankaddr1 = ls_entity-zbankaddr1.
    wa_data-zbankname1 = ls_entity-Zbankname1.
    wa_data-zvendorbankifsc = ls_entity-Zvendorbankifsc.
    wa_data-zvendorbankname = ls_entity-Zvendorbankname.
    wa_data-zvendorbankaddr = ls_entity-Zvendorbankaddr.
          wa_data-zdms                = ls_entity-DMS.
      wa_data-zfile               = ls_entity-FileNo.
      wa_data-zmimetype           = ls_entity-MimeType.
      wa_data-zfilename           = ls_entity-FileName.


    wa_data-createdon =
      cl_abap_context_info=>get_system_date( ).

    wa_data-createdat =
      cl_abap_context_info=>get_system_time( ).

    wa_data-createdby =
      cl_abap_context_info=>get_user_technical_name( ).

    DATA(lv_date) =
      cl_abap_context_info=>get_system_date( ).

    IF wa_data-lc_date IS NOT INITIAL.
      lv_date = wa_data-lc_date.
    ENDIF.

    DATA:
      lv_year  TYPE i,
      lv_month TYPE i.

    lv_year  = lv_date+0(4).
    lv_month = lv_date+4(2).

    IF lv_month >= 4.
      lv_fyear = lv_year.
    ELSE.
      lv_fyear = lv_year - 1.
    ENDIF.

    lv_pattern =
      |{ lc_prefix }{ wa_data-company_code }{ lv_fyear }%|.

    SELECT SINGLE MAX( lc_number )
      FROM zfi_inward_lc
      WHERE company_code = @wa_data-company_code
        AND lc_number LIKE @lv_pattern
      INTO @lv_max_lc.

    IF lv_max_lc IS NOT INITIAL.

      DATA(lv_length) = strlen( lv_max_lc ).

      IF lv_length >= 4.

        DATA(lv_offset) = lv_length - 4.

        DATA(lv_serial_text) =
          lv_max_lc+lv_offset(4).

        lv_max_num =
          CONV numc4( lv_serial_text ).

      ENDIF.

    ENDIF.

    LOOP AT lhc_buffer=>mt_buffer
      INTO DATA(ls_buffer)
      WHERE company_code = wa_data-company_code.

      IF ls_buffer-lc_number IS NOT INITIAL.

        DATA(lv_buf_length) =
          strlen( ls_buffer-lc_number ).

        IF lv_buf_length >= 4.

          DATA(lv_buf_offset) =
            lv_buf_length - 4.

          DATA(lv_buf_serial) =
            ls_buffer-lc_number+lv_buf_offset(4).

          DATA lv_buf_num TYPE numc4.

          lv_buf_num =
            CONV numc4( lv_buf_serial ).

          IF lv_buf_num > lv_max_num.
            lv_max_num = lv_buf_num.
          ENDIF.

        ENDIF.

      ENDIF.

    ENDLOOP.

    lv_running = lv_max_num + 1.

    wa_data-lc_number =
      |{ lc_prefix }{ wa_data-company_code }{ lv_fyear }{ lv_running WIDTH = 4 PAD = '0' }|.

    APPEND wa_data TO lhc_buffer=>mt_buffer.

    APPEND VALUE #(
      %cid     = ls_entity-%cid
      CompanyCode = wa_data-company_code
      LcNumber = wa_data-lc_number
    ) TO mapped-zfi_inward_lc_cds.

  ENDLOOP.

  ENDMETHOD.

  METHOD update.

  LOOP AT entities INTO DATA(ls_entity).

    SELECT SINGLE *
      FROM zfi_inward_lc
      WHERE company_code = @ls_entity-CompanyCode
        AND lc_number    = @ls_entity-LcNumber
      INTO @DATA(ls_old).

    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.

    DATA(ls_data) = ls_old.

    ls_data-company_code = ls_old-company_code.
    ls_data-lc_number    = ls_old-lc_number.

    IF ls_entity-%control-LcBankNumber = if_abap_behv=>mk-on.
      ls_data-lc_banknumber = ls_entity-LcBankNumber.
    ENDIF.

    IF ls_entity-%control-LcType = if_abap_behv=>mk-on.
      ls_data-lc_type = ls_entity-LcType.
    ENDIF.

    IF ls_entity-%control-VendorCode = if_abap_behv=>mk-on.
      ls_data-vendor_code = ls_entity-VendorCode.
    ENDIF.

    IF ls_entity-%control-VendorName = if_abap_behv=>mk-on.
      ls_data-vendor_name = ls_entity-VendorName.
    ENDIF.

    IF ls_entity-%control-IssuingBank = if_abap_behv=>mk-on.
      ls_data-issuing_bank = ls_entity-IssuingBank.
    ENDIF.

    IF ls_entity-%control-LcCurrency = if_abap_behv=>mk-on.
      ls_data-lc_currency = ls_entity-LcCurrency.
    ENDIF.

    IF ls_entity-%control-LcAmount = if_abap_behv=>mk-on.
      ls_data-lc_amount = ls_entity-LcAmount.
    ENDIF.

    IF ls_entity-%control-AmountVersion = if_abap_behv=>mk-on.
      IF ls_entity-AmountVersion IS NOT INITIAL.
        ls_data-amount_version = ls_entity-AmountVersion.
      ENDIF.
    ENDIF.

    IF ls_entity-%control-LsdVersion = if_abap_behv=>mk-on.
      IF ls_entity-LsdVersion IS NOT INITIAL.
        ls_data-lsd_version = ls_entity-LsdVersion.
      ENDIF.
    ENDIF.

    IF ls_entity-%control-EdVersion = if_abap_behv=>mk-on.
      IF ls_entity-EdVersion IS NOT INITIAL.
        ls_data-ed_version = ls_entity-EdVersion.
      ENDIF.
    ENDIF.

    IF ls_entity-%control-TolerancePercent = if_abap_behv=>mk-on.
      ls_data-tolerance_percent = ls_entity-TolerancePercent.
    ENDIF.

    IF ls_entity-%control-ToleranceAmount = if_abap_behv=>mk-on.
      ls_data-tolerance_amount = ls_entity-ToleranceAmount.
    ENDIF.

    IF ls_entity-%control-TotalLcAmount = if_abap_behv=>mk-on.
      ls_data-total_lc_amount = ls_entity-TotalLcAmount.
    ENDIF.

    IF ls_entity-%control-LcDate = if_abap_behv=>mk-on.
      ls_data-lc_date = ls_entity-LcDate.
    ENDIF.

    IF ls_entity-%control-LastShipmentDate = if_abap_behv=>mk-on.
      ls_data-last_shipment_date = ls_entity-LastShipmentDate.
    ENDIF.

    IF ls_entity-%control-ExpiryDate = if_abap_behv=>mk-on.
      ls_data-expiry_date = ls_entity-ExpiryDate.
    ENDIF.

    IF ls_entity-%control-LcPercent = if_abap_behv=>mk-on.
      ls_data-lc_percent = ls_entity-LcPercent.
    ENDIF.

    IF ls_entity-%control-PurchaseOrder = if_abap_behv=>mk-on.
      ls_data-purchase_order = ls_entity-PurchaseOrder.
    ENDIF.

    IF ls_entity-%control-PoDate = if_abap_behv=>mk-on.
      ls_data-po_date = ls_entity-PoDate.
    ENDIF.

    IF ls_entity-%control-BasicPoAmount = if_abap_behv=>mk-on.
      ls_data-basic_po_amount = ls_entity-BasicPoAmount.
    ENDIF.

    IF ls_entity-%control-GstAmount = if_abap_behv=>mk-on.
      ls_data-gst_amount = ls_entity-GstAmount.
    ENDIF.

    IF ls_entity-%control-TotalPoAmount = if_abap_behv=>mk-on.
      ls_data-total_po_amount = ls_entity-TotalPoAmount.
    ENDIF.

    IF ls_entity-%control-TdsAmount = if_abap_behv=>mk-on.
      ls_data-tds_amount = ls_entity-TdsAmount.
    ENDIF.

    IF ls_entity-%control-BoeDuePeriod = if_abap_behv=>mk-on.
      ls_data-boe_due_period = ls_entity-BoeDuePeriod.
    ENDIF.

    IF ls_entity-%control-ExecutionStatus = if_abap_behv=>mk-on.
      ls_data-execution_status = ls_entity-ExecutionStatus.
    ENDIF.

    IF ls_entity-%control-IssuanceStatus = if_abap_behv=>mk-on.
      ls_data-issuance_status = ls_entity-IssuanceStatus.
    ENDIF.

    IF ls_entity-%control-ShortClosedAmount = if_abap_behv=>mk-on.
      ls_data-short_closed_amount = ls_entity-ShortClosedAmount.
    ENDIF.

    IF ls_entity-%control-Remarks = if_abap_behv=>mk-on.
      ls_data-remarks = ls_entity-Remarks.
    ENDIF.

    IF ls_entity-%control-Descrepancies = if_abap_behv=>mk-on.
      ls_data-descrepancies = ls_entity-Descrepancies.
    ENDIF.

    APPEND ls_data TO lhc_buffer=>mt_buffer.

  ENDLOOP.

ENDMETHOD.


  METHOD delete.
  LOOP AT keys INTO DATA(ls_key).

    APPEND VALUE #(
      company_code = ls_key-CompanyCode
      lc_number    = ls_key-LcNumber
    ) TO lhc_buffer=>mt_delete.

  ENDLOOP.
  ENDMETHOD.

  METHOD read.

  LOOP AT keys INTO DATA(ls_key).

    SELECT SINGLE *
      FROM zfi_inward_lc
      WHERE company_code = @ls_key-CompanyCode
        AND lc_number    = @ls_key-LcNumber
      INTO @DATA(ls_data).

    IF sy-subrc = 0.

      APPEND VALUE #(
        %tky = ls_key-%tky

        CompanyCode        = ls_data-company_code
        LcNumber           = ls_data-lc_number
        LcBankNumber       = ls_data-lc_banknumber
        LcType              = ls_data-lc_type
        VendorCode          = ls_data-vendor_code
        VendorName          = ls_data-vendor_name
        IssuingBank         = ls_data-issuing_bank
        LcCurrency          = ls_data-lc_currency
        LcAmount            = ls_data-lc_amount
        AmountVersion       = ls_data-amount_version
        TolerancePercent    = ls_data-tolerance_percent
        ToleranceAmount     = ls_data-tolerance_amount
        TotalLcAmount       = ls_data-total_lc_amount
        LcDate              = ls_data-lc_date
        LastShipmentDate    = ls_data-last_shipment_date
        LsdVersion          = ls_data-lsd_version
        ExpiryDate          = ls_data-expiry_date
        EdVersion           = ls_data-ed_version
        LcPercent           = ls_data-lc_percent
        PurchaseOrder       = ls_data-purchase_order
        PoDate              = ls_data-po_date
        BasicPoAmount       = ls_data-basic_po_amount
        GstAmount           = ls_data-gst_amount
        TotalPoAmount       = ls_data-total_po_amount
        TdsAmount           = ls_data-tds_amount
        BoeDuePeriod        = ls_data-boe_due_period
        ExecutionStatus     = ls_data-execution_status
        IssuanceStatus      = ls_data-issuance_status
        ShortClosedAmount   = ls_data-short_closed_amount
        Remarks             = ls_data-remarks
        Descrepancies       = ls_data-descrepancies
        CreatedOn           = ls_data-createdon
        CreatedAt           = ls_data-createdat
        CreatedBy           = ls_data-createdby
            lcmargin = ls_data-Lcmargin
    lcmarginamt = ls_data-Lcmarginamt
    commamount = ls_data-commamount
    commbasis = ls_data-commbasis
    commrate = ls_data-commrate
    lctenure = ls_data-lctenure

      ) TO result.

    ELSE.

      APPEND VALUE #(
        %tky = ls_key-%tky
        %fail = VALUE #(
          cause = if_abap_behv=>cause-not_found
        )
      ) TO failed-zfi_inward_lc_cds.

    ENDIF.

  ENDLOOP.

ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZFI_INWARD_LC_CDS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZFI_INWARD_LC_CDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

  "------------------------------------------------------------
  " DELETE OLD LC
  "------------------------------------------------------------
  LOOP AT lhc_buffer=>mt_delete INTO DATA(ls_delete).

    DELETE FROM zfi_inward_lc
      WHERE company_code = @ls_delete-company_code
        AND lc_number    = @ls_delete-lc_number.

  ENDLOOP.


  "------------------------------------------------------------
  " CREATE / UPDATE
  "------------------------------------------------------------
  LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer).

    MODIFY zfi_inward_lc FROM @ls_buffer.

  ENDLOOP.


  "------------------------------------------------------------
  " CLEAR BUFFER
  "------------------------------------------------------------
  CLEAR:
    lhc_buffer=>mt_buffer,
    lhc_buffer=>mt_delete.

ENDMETHOD.

  METHOD cleanup.
  CLEAR: lhc_buffer=>mt_buffer,
         lhc_buffer=>mt_delete.
  ENDMETHOD.

  METHOD cleanup_finalize.
  CLEAR: lhc_buffer=>mt_buffer,
         lhc_buffer=>mt_delete.
  ENDMETHOD.

ENDCLASS.
