CLASS lhc_buffer DEFINITION.

* 1) define the data buffer

  PUBLIC SECTION.

    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_olc_boe.

ENDCLASS.


CLASS lhc_ZFI_OLC_BOE_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations
      FOR zfi_olc_boe_cds RESULT result.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations
      FOR zfi_olc_boe_cds RESULT result.

    METHODS create
      FOR MODIFY
      entities FOR CREATE zfi_olc_boe_cds.

    METHODS update
      FOR MODIFY
      entities FOR UPDATE zfi_olc_boe_cds.

    METHODS delete
      FOR MODIFY
      keys FOR DELETE zfi_olc_boe_cds.

    METHODS read
      FOR READ
      keys FOR READ zfi_olc_boe_cds RESULT result.

    METHODS lock
      FOR LOCK
      keys FOR LOCK zfi_olc_boe_cds.

ENDCLASS.


CLASS lhc_ZFI_OLC_BOE_CDS IMPLEMENTATION.


  METHOD get_instance_authorizations.

  ENDMETHOD.


  METHOD get_global_authorizations.

  ENDMETHOD.


  METHOD create.

    DATA:
      wa_data TYPE zfi_olc_boe.

    LOOP AT entities INTO DATA(ls_entity).

      CLEAR wa_data.


*---------------------------------------------------------------
* Check LC Number in Outward LC Master
*---------------------------------------------------------------

      SELECT SINGLE zlcnumber
        FROM zfi_outward_lc
        WHERE zlcnumber = @ls_entity-Zlcnumber
        INTO @DATA(lv_lc_number).


      IF sy-subrc <> 0.

        APPEND VALUE #(

          %cid = ls_entity-%cid

          %msg = new_message_with_text(

                   severity = if_abap_behv_message=>severity-error

                   text = 'Invalid LC Number. LC does not exist in Outward LC Master.'

                 )

        ) TO reported-zfi_olc_boe_cds.

        CONTINUE.

      ENDIF.

      wa_data-zboeno = ls_entity-Zboeno.
      wa_data-zlcnumber = lv_lc_number.
      wa_data-zboedate = ls_entity-ZboeDate.
      wa_data-zboetype = ls_entity-ZboeType.
      wa_data-zbillingdoc = ls_entity-ZbillingDoc.
      wa_data-zinvoiceamt = ls_entity-ZinvoiceAmt.
      wa_data-zboeamount = ls_entity-ZboeAmount.
      wa_data-zcurrency = ls_entity-Zcurrency.
      wa_data-zapplicabledate = ls_entity-ZapplicableDate.
      wa_data-zboeduedate = ls_entity-ZboeDueDate.
      wa_data-zboestatus = ls_entity-ZboeStatus.
      wa_data-zremarks = ls_entity-Zremarks.
      wa_data-zpaymentstatus = ls_entity-ZpaymentStatus.
      wa_data-zdescrepancies = ls_entity-Zdescrepancies.
      wa_data-created_by = cl_abap_context_info=>get_user_technical_name( ).
      wa_data-created_at = utclong_current( ).

      APPEND wa_data TO lhc_buffer=>mt_buffer.

      APPEND VALUE #(

        %cid      = ls_entity-%cid

        Zlcnumber = wa_data-zlcnumber

        Zboeno    = wa_data-zboeno

      ) TO mapped-zfi_olc_boe_cds.


    ENDLOOP.

  ENDMETHOD.



  METHOD update.

    LOOP AT entities INTO DATA(ls_entity).

      DATA(ls_data) = VALUE zfi_olc_boe( ).

      ls_data-zlcnumber = ls_entity-Zlcnumber.

      ls_data-zboeno = ls_entity-Zboeno.

      IF ls_entity-%control-ZboeDate = if_abap_behv=>mk-on.
        ls_data-zboedate = ls_entity-ZboeDate.
      ENDIF.

      IF ls_entity-%control-ZboeType = if_abap_behv=>mk-on.
        ls_data-zboetype = ls_entity-ZboeType.
      ENDIF.

      IF ls_entity-%control-ZbillingDoc = if_abap_behv=>mk-on.
        ls_data-zbillingdoc = ls_entity-ZbillingDoc.
      ENDIF.

      IF ls_entity-%control-ZinvoiceAmt = if_abap_behv=>mk-on.
        ls_data-zinvoiceamt = ls_entity-ZinvoiceAmt.
      ENDIF.

      IF ls_entity-%control-ZboeAmount = if_abap_behv=>mk-on.
        ls_data-zboeamount = ls_entity-ZboeAmount.
      ENDIF.

      IF ls_entity-%control-Zcurrency = if_abap_behv=>mk-on.
        ls_data-zcurrency = ls_entity-Zcurrency.
      ENDIF.

      IF ls_entity-%control-ZapplicableDate = if_abap_behv=>mk-on.
        ls_data-zapplicabledate = ls_entity-ZapplicableDate.
      ENDIF.

      IF ls_entity-%control-ZboeDueDate = if_abap_behv=>mk-on.
        ls_data-zboeduedate = ls_entity-ZboeDueDate.
      ENDIF.

      IF ls_entity-%control-ZboeStatus = if_abap_behv=>mk-on.
        ls_data-zboestatus = ls_entity-ZboeStatus.
      ENDIF.

      IF ls_entity-%control-Zremarks = if_abap_behv=>mk-on.
        ls_data-zremarks = ls_entity-Zremarks.
      ENDIF.

      IF ls_entity-%control-ZpaymentStatus = if_abap_behv=>mk-on.
        ls_data-zpaymentstatus = ls_entity-ZpaymentStatus.
      ENDIF.

      IF ls_entity-%control-Zdescrepancies = if_abap_behv=>mk-on.
        ls_data-zdescrepancies = ls_entity-Zdescrepancies.
      ENDIF.

      ls_data-last_changed_by = cl_abap_context_info=>get_user_technical_name( ).

      ls_data-last_changed_at = utclong_current( ).

      APPEND ls_data TO lhc_buffer=>mt_buffer.

    ENDLOOP.

  ENDMETHOD.



  METHOD delete.

    LOOP AT keys INTO DATA(ls_key).

      DELETE FROM zfi_olc_boe
        WHERE zlcnumber = @ls_key-Zlcnumber
          AND zboeno    = @ls_key-Zboeno.

    ENDLOOP.

  ENDMETHOD.



  METHOD read.

  ENDMETHOD.



  METHOD lock.

  ENDMETHOD.

ENDCLASS.



CLASS lsc_ZFI_OLC_BOE_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.



CLASS lsc_ZFI_OLC_BOE_CDS IMPLEMENTATION.


  METHOD finalize.

  ENDMETHOD.


  METHOD check_before_save.

  ENDMETHOD.


  METHOD save.

    LOOP AT lhc_buffer=>mt_buffer
      INTO DATA(ls_buffer).

      SELECT SINGLE *
        FROM zfi_olc_boe
        WHERE zlcnumber = @ls_buffer-zlcnumber
          AND zboeno    = @ls_buffer-zboeno
        INTO @DATA(ls_db).

      IF sy-subrc = 0.

        IF ls_buffer-zboedate IS NOT INITIAL.
          ls_db-zboedate = ls_buffer-zboedate.
        ENDIF.

        IF ls_buffer-zboetype IS NOT INITIAL.
          ls_db-zboetype = ls_buffer-zboetype.
        ENDIF.

        IF ls_buffer-zbillingdoc IS NOT INITIAL.
          ls_db-zbillingdoc = ls_buffer-zbillingdoc.
        ENDIF.

        IF ls_buffer-zinvoiceamt IS NOT INITIAL.
          ls_db-zinvoiceamt = ls_buffer-zinvoiceamt.
        ENDIF.

        IF ls_buffer-zboeamount IS NOT INITIAL.
          ls_db-zboeamount = ls_buffer-zboeamount.
        ENDIF.

        IF ls_buffer-zcurrency IS NOT INITIAL.
          ls_db-zcurrency = ls_buffer-zcurrency.
        ENDIF.

        IF ls_buffer-zapplicabledate IS NOT INITIAL.
          ls_db-zapplicabledate = ls_buffer-zapplicabledate.
        ENDIF.

        IF ls_buffer-zboeduedate IS NOT INITIAL.
          ls_db-zboeduedate = ls_buffer-zboeduedate.
        ENDIF.

        IF ls_buffer-zboestatus IS NOT INITIAL.
          ls_db-zboestatus = ls_buffer-zboestatus.
        ENDIF.

        IF ls_buffer-zremarks IS NOT INITIAL.
          ls_db-zremarks = ls_buffer-zremarks.
        ENDIF.

        IF ls_buffer-zpaymentstatus IS NOT INITIAL.
          ls_db-zpaymentstatus = ls_buffer-zpaymentstatus.
        ENDIF.

        IF ls_buffer-zdescrepancies IS NOT INITIAL.
          ls_db-zdescrepancies = ls_buffer-zdescrepancies.
        ENDIF.

        ls_db-last_changed_by = cl_abap_context_info=>get_user_technical_name( ).

        ls_db-last_changed_at = utclong_current( ).

        MODIFY zfi_olc_boe FROM @ls_db.


      ELSE.

        INSERT zfi_olc_boe FROM @ls_buffer.

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
