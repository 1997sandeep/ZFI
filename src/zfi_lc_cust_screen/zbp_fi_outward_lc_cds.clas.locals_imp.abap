CLASS lhc_buffer DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_outward_lc.

ENDCLASS.


CLASS lhc_ZFI_OUTWARD_LC_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations
      FOR zfi_outward_lc_cds RESULT result.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations
      FOR zfi_outward_lc_cds RESULT result.

    METHODS create
      FOR MODIFY
      entities FOR CREATE zfi_outward_lc_cds.

    METHODS update
      FOR MODIFY
      entities FOR UPDATE zfi_outward_lc_cds.

    METHODS delete
      FOR MODIFY
      keys FOR DELETE zfi_outward_lc_cds.

    METHODS read
      FOR READ
      keys FOR READ zfi_outward_lc_cds RESULT result.

    METHODS lock
      FOR LOCK
      keys FOR LOCK zfi_outward_lc_cds.

ENDCLASS.


CLASS lhc_ZFI_OUTWARD_LC_CDS IMPLEMENTATION.


  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD create.

    DATA: wa_data TYPE zfi_outward_lc.

    LOOP AT entities INTO DATA(ls_entity).

      CLEAR wa_data.

      wa_data-zlcnumber = ls_entity-Zlcnumber.
      wa_data-company_code = ls_entity-CompanyCode.
      wa_data-lc_banknumber = ls_entity-LcBankNumber.
      wa_data-job_no = ls_entity-JobNo.
      wa_data-sales_order = ls_entity-SalesOrder.
      wa_data-customer_code = ls_entity-CustomerCode.
      wa_data-customer_name = ls_entity-CustomerName.
      wa_data-zlcdate = ls_entity-Zlcdate.
      wa_data-zlctype = ls_entity-Zlctype.
      wa_data-zlcissuingbank = ls_entity-ZlcIssuingBank.
      wa_data-zlcnegotiatingbank = ls_entity-ZlcNegotiatingBank.
      wa_data-zlastshipmentdate = ls_entity-ZlastShipmentDate.
      wa_data-zlsdversion = ls_entity-ZlsdVersion.
      wa_data-zexpirydate = ls_entity-ZexpiryDate.
      wa_data-zedversion = ls_entity-ZedVersion.
      wa_data-zlcpercent = ls_entity-ZlcPercent.
      wa_data-order_amount_basic = ls_entity-OrderAmountBasic.
      wa_data-gst_amount = ls_entity-GstAmount.
      wa_data-order_amount_gst = ls_entity-OrderAmountGst.
      wa_data-zlcamount = ls_entity-ZlcAmount.
      wa_data-zlcamountversion = ls_entity-ZlcAmountVersion.
      wa_data-tds_percentage = ls_entity-TdsPercentage.
      wa_data-zboedueperiod = ls_entity-ZboeDuePeriod.
      wa_data-zremarks = ls_entity-Zremarks.
      wa_data-zstatus = ls_entity-Zstatus.
      wa_data-zdescrepancies = ls_entity-Zdescrepancies.
      wa_data-currency_code = ls_entity-CurrencyCode.
      wa_data-created_by = cl_abap_context_info=>get_user_technical_name( ).
      wa_data-created_at = utclong_current( ).

      APPEND wa_data TO lhc_buffer=>mt_buffer.

      APPEND VALUE #(
        %cid      = ls_entity-%cid
        Zlcnumber = wa_data-zlcnumber
      ) TO mapped-zfi_outward_lc_cds.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    LOOP AT entities INTO DATA(ls_entity).

      DATA(ls_data) = VALUE zfi_outward_lc( ).
      ls_data-zlcnumber = ls_entity-Zlcnumber.

      IF ls_entity-%control-CompanyCode = if_abap_behv=>mk-on.

        ls_data-company_code = ls_entity-CompanyCode.

      ENDIF.

      IF ls_entity-%control-LcBankNumber = if_abap_behv=>mk-on.

        ls_data-lc_banknumber = ls_entity-LcBankNumber.

      ENDIF.

      IF ls_entity-%control-JobNo = if_abap_behv=>mk-on.

        ls_data-job_no = ls_entity-JobNo.

      ENDIF.

      IF ls_entity-%control-SalesOrder = if_abap_behv=>mk-on.

        ls_data-sales_order = ls_entity-SalesOrder.

      ENDIF.

      IF ls_entity-%control-CustomerCode = if_abap_behv=>mk-on.

        ls_data-customer_code = ls_entity-CustomerCode.

      ENDIF.

      IF ls_entity-%control-CustomerName = if_abap_behv=>mk-on.

        ls_data-customer_name = ls_entity-CustomerName.

      ENDIF.

      IF ls_entity-%control-Zlcdate = if_abap_behv=>mk-on.

        ls_data-zlcdate = ls_entity-Zlcdate.

      ENDIF.

      IF ls_entity-%control-Zlctype = if_abap_behv=>mk-on.

        ls_data-zlctype = ls_entity-Zlctype.

      ENDIF.

      IF ls_entity-%control-ZlcIssuingBank = if_abap_behv=>mk-on.

        ls_data-zlcissuingbank = ls_entity-ZlcIssuingBank.

      ENDIF.

      IF ls_entity-%control-ZlcNegotiatingBank = if_abap_behv=>mk-on.

        ls_data-zlcnegotiatingbank = ls_entity-ZlcNegotiatingBank.

      ENDIF.

      IF ls_entity-%control-ZlastShipmentDate = if_abap_behv=>mk-on.

        ls_data-zlastshipmentdate = ls_entity-ZlastShipmentDate.

      ENDIF.

      IF ls_entity-%control-ZlsdVersion = if_abap_behv=>mk-on.

        ls_data-zlsdversion = ls_entity-ZlsdVersion.

      ENDIF.

      IF ls_entity-%control-ZexpiryDate = if_abap_behv=>mk-on.

        ls_data-zexpirydate = ls_entity-ZexpiryDate.

      ENDIF.

      IF ls_entity-%control-ZedVersion = if_abap_behv=>mk-on.

        ls_data-zedversion = ls_entity-ZedVersion.

      ENDIF.

      IF ls_entity-%control-ZlcPercent = if_abap_behv=>mk-on.

        ls_data-zlcpercent = ls_entity-ZlcPercent.

      ENDIF.

      IF ls_entity-%control-OrderAmountBasic = if_abap_behv=>mk-on.

        ls_data-order_amount_basic = ls_entity-OrderAmountBasic.

      ENDIF.

      IF ls_entity-%control-GstAmount = if_abap_behv=>mk-on.

        ls_data-gst_amount = ls_entity-GstAmount.

      ENDIF.

      IF ls_entity-%control-OrderAmountGst = if_abap_behv=>mk-on.

        ls_data-order_amount_gst = ls_entity-OrderAmountGst.

      ENDIF.

      IF ls_entity-%control-ZlcAmount = if_abap_behv=>mk-on.

        ls_data-zlcamount = ls_entity-ZlcAmount.

      ENDIF.

      IF ls_entity-%control-ZlcAmountVersion = if_abap_behv=>mk-on.

        ls_data-zlcamountversion = ls_entity-ZlcAmountVersion.

      ENDIF.

      IF ls_entity-%control-TdsPercentage = if_abap_behv=>mk-on.

        ls_data-tds_percentage = ls_entity-TdsPercentage.

      ENDIF.

      IF ls_entity-%control-ZboeDuePeriod = if_abap_behv=>mk-on.

        ls_data-zboedueperiod = ls_entity-ZboeDuePeriod.

      ENDIF.

      IF ls_entity-%control-Zremarks = if_abap_behv=>mk-on.

        ls_data-zremarks = ls_entity-Zremarks.

      ENDIF.

      IF ls_entity-%control-Zstatus = if_abap_behv=>mk-on.

        ls_data-zstatus = ls_entity-Zstatus.

      ENDIF.

      IF ls_entity-%control-Zdescrepancies = if_abap_behv=>mk-on.

        ls_data-zdescrepancies = ls_entity-Zdescrepancies.

      ENDIF.

      IF ls_entity-%control-CurrencyCode = if_abap_behv=>mk-on.

        ls_data-currency_code = ls_entity-CurrencyCode.

      ENDIF.

      APPEND ls_data TO lhc_buffer=>mt_buffer.

    ENDLOOP.

  ENDMETHOD.


  METHOD delete.
  LOOP AT keys INTO DATA(ls_key).

    DELETE FROM zfi_outward_lc
      WHERE zlcnumber = @ls_key-Zlcnumber.

  ENDLOOP.
  ENDMETHOD.


  METHOD read.

  ENDMETHOD.


  METHOD lock.

  ENDMETHOD.

ENDCLASS.



CLASS lsc_ZFI_OUTWARD_LC_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.



CLASS lsc_ZFI_OUTWARD_LC_CDS IMPLEMENTATION.


  METHOD finalize.

  ENDMETHOD.


  METHOD check_before_save.

  ENDMETHOD.


  METHOD save.

    LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer).

      SELECT SINGLE *
        FROM zfi_outward_lc
        WHERE zlcnumber = @ls_buffer-zlcnumber
        INTO @DATA(ls_db).

      IF sy-subrc = 0.

        IF ls_buffer-company_code IS NOT INITIAL.

          ls_db-company_code = ls_buffer-company_code.

        ENDIF.

        IF ls_buffer-lc_banknumber IS NOT INITIAL.

          ls_db-lc_banknumber = ls_buffer-lc_banknumber.

        ENDIF.

        IF ls_buffer-job_no IS NOT INITIAL.

          ls_db-job_no = ls_buffer-job_no.

        ENDIF.

        IF ls_buffer-sales_order IS NOT INITIAL.

          ls_db-sales_order = ls_buffer-sales_order.

        ENDIF.

        IF ls_buffer-customer_code IS NOT INITIAL.

          ls_db-customer_code = ls_buffer-customer_code.

        ENDIF.

        IF ls_buffer-customer_name IS NOT INITIAL.

          ls_db-customer_name = ls_buffer-customer_name.

        ENDIF.

        IF ls_buffer-zlcdate IS NOT INITIAL.

          ls_db-zlcdate = ls_buffer-zlcdate.

        ENDIF.

        IF ls_buffer-zlctype IS NOT INITIAL.

          ls_db-zlctype = ls_buffer-zlctype.

        ENDIF.

        IF ls_buffer-zlcissuingbank IS NOT INITIAL.

          ls_db-zlcissuingbank = ls_buffer-zlcissuingbank.

        ENDIF.

        IF ls_buffer-zlcnegotiatingbank IS NOT INITIAL.

          ls_db-zlcnegotiatingbank = ls_buffer-zlcnegotiatingbank.

        ENDIF.

        IF ls_buffer-zlastshipmentdate IS NOT INITIAL.

          ls_db-zlastshipmentdate = ls_buffer-zlastshipmentdate.

        ENDIF.

        IF ls_buffer-zlsdversion IS NOT INITIAL.

          ls_db-zlsdversion = ls_buffer-zlsdversion.

        ENDIF.

        IF ls_buffer-zexpirydate IS NOT INITIAL.

          ls_db-zexpirydate = ls_buffer-zexpirydate.

        ENDIF.

        IF ls_buffer-zedversion IS NOT INITIAL.

          ls_db-zedversion = ls_buffer-zedversion.

        ENDIF.

        IF ls_buffer-zlcpercent IS NOT INITIAL.

          ls_db-zlcpercent = ls_buffer-zlcpercent.

        ENDIF.

        IF ls_buffer-order_amount_basic IS NOT INITIAL.

          ls_db-order_amount_basic = ls_buffer-order_amount_basic.

        ENDIF.

        IF ls_buffer-gst_amount IS NOT INITIAL.

          ls_db-gst_amount = ls_buffer-gst_amount.

        ENDIF.

        IF ls_buffer-order_amount_gst IS NOT INITIAL.

          ls_db-order_amount_gst = ls_buffer-order_amount_gst.

        ENDIF.

        IF ls_buffer-zlcamount IS NOT INITIAL.

          ls_db-zlcamount = ls_buffer-zlcamount.

        ENDIF.

        IF ls_buffer-zlcamountversion IS NOT INITIAL.

          ls_db-zlcamountversion = ls_buffer-zlcamountversion.

        ENDIF.

        IF ls_buffer-tds_percentage IS NOT INITIAL.

          ls_db-tds_percentage = ls_buffer-tds_percentage.

        ENDIF.

        IF ls_buffer-zboedueperiod IS NOT INITIAL.

          ls_db-zboedueperiod = ls_buffer-zboedueperiod.

        ENDIF.

        IF ls_buffer-zremarks IS NOT INITIAL.

          ls_db-zremarks = ls_buffer-zremarks.

        ENDIF.

        IF ls_buffer-zstatus IS NOT INITIAL.

          ls_db-zstatus = ls_buffer-zstatus.

        ENDIF.

        IF ls_buffer-zdescrepancies IS NOT INITIAL.

          ls_db-zdescrepancies = ls_buffer-zdescrepancies.

        ENDIF.

        IF ls_buffer-currency_code IS NOT INITIAL.

          ls_db-currency_code = ls_buffer-currency_code.

        ENDIF.

        MODIFY zfi_outward_lc FROM @ls_db.


      ELSE.

        INSERT zfi_outward_lc FROM @ls_buffer.


      ENDIF.


      CLEAR ls_db.

    ENDLOOP.


    CLEAR lhc_buffer=>mt_buffer.

  ENDMETHOD.


  METHOD cleanup.

  ENDMETHOD.


  METHOD cleanup_finalize.

  ENDMETHOD.

ENDCLASS.
