CLASS lhc_buffer DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_customer_bg.

    CLASS-DATA mt_delete TYPE STANDARD TABLE OF zfi_customer_bg.

ENDCLASS.



CLASS lhc_ZFI_CUSTOMER_BG_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    CONSTANTS lc_prefix TYPE char3 VALUE 'AR-'.


    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations
      FOR zfi_customer_bg_cds RESULT result.


    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations
      FOR zfi_customer_bg_cds RESULT result.


    METHODS create
      FOR MODIFY
      IMPORTING entities FOR CREATE zfi_customer_bg_cds.


    METHODS update
      FOR MODIFY
      IMPORTING entities FOR UPDATE zfi_customer_bg_cds.


    METHODS delete
      FOR MODIFY
      IMPORTING keys FOR DELETE zfi_customer_bg_cds.


    METHODS read
      FOR READ
      IMPORTING keys FOR READ zfi_customer_bg_cds RESULT result.


    METHODS lock
      FOR LOCK
      IMPORTING keys FOR LOCK zfi_customer_bg_cds.

ENDCLASS.



CLASS lhc_ZFI_CUSTOMER_BG_CDS IMPLEMENTATION.


  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD create.

    DATA:
      wa_data          TYPE zfi_customer_bg,
      ls_existing      TYPE zfi_customer_bg,

      lv_max_num       TYPE numc4,
      lv_running       TYPE numc4,
      lv_fyear         TYPE numc4,

      lv_pattern       TYPE string,
      lv_max_slno      TYPE zfi_customer_bg-zslno,

      lv_year          TYPE i,
      lv_month         TYPE i,

      lv_buf_num       TYPE numc4,

      lv_existing_slno TYPE zfi_customer_bg-zslno,

      lv_date          TYPE d.


    LOOP AT entities INTO DATA(ls_entity).


      CLEAR:
        wa_data,
        ls_existing,
        lv_max_num,
        lv_running,
        lv_fyear,

        lv_pattern,
        lv_max_slno,

        lv_year,
        lv_month,

        lv_buf_num,

        lv_existing_slno,

        lv_date.

      IF ls_entity-Zbgamount IS INITIAL.

        APPEND VALUE #(
          %tky = ls_entity-%key
        ) TO failed-zfi_customer_bg_cds.

        APPEND VALUE #(
          %tky = ls_entity-%key
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |Please maintain BG amount|
          )
          %element-Zbgamount = if_abap_behv=>mk-on
        ) TO reported-zfi_customer_bg_cds.

        RETURN.

      ENDIF.
      IF ls_entity-Zbgclaimdate IS INITIAL.

        APPEND VALUE #(
          %tky = ls_entity-%key
        ) TO failed-zfi_customer_bg_cds.

        APPEND VALUE #(
          %tky = ls_entity-%key
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |Please maintain BG Claim Date|
          )
          %element-Zbgamount = if_abap_behv=>mk-on
        ) TO reported-zfi_customer_bg_cds.

        RETURN.

      ENDIF.
      IF ls_entity-Zbgexpirydate IS INITIAL.

        APPEND VALUE #(
          %tky = ls_entity-%key
        ) TO failed-zfi_customer_bg_cds.

        APPEND VALUE #(
          %tky = ls_entity-%key
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |Please maintain BG Expiry Date|
          )
          %element-Zbgamount = if_abap_behv=>mk-on
        ) TO reported-zfi_customer_bg_cds.

        RETURN.

      ENDIF.
      IF ls_entity-Zbgissuancedate IS INITIAL.

        APPEND VALUE #(
          %tky = ls_entity-%key
        ) TO failed-zfi_customer_bg_cds.

        APPEND VALUE #(
          %tky = ls_entity-%key
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = |Please maintain BG Issuance Date|
          )
          %element-Zbgamount = if_abap_behv=>mk-on
        ) TO reported-zfi_customer_bg_cds.

        RETURN.

      ENDIF.



      wa_data-zprofitcenter = ls_entity-Zprofitcenter.
      wa_data-zconcernperson = ls_entity-Zconcernperson.
      wa_data-zjobnumber = ls_entity-Zjobnumber.
      wa_data-zbeneficiarycode = ls_entity-Zbeneficiarycode.
      wa_data-zbeneficiaryname = ls_entity-Zbeneficiaryname.
      wa_data-zbgnumber = ls_entity-Zbgnumber.
      wa_data-zbgpurpose = ls_entity-Zbgpurpose.
      wa_data-zbgtype = ls_entity-Zbgtype.
      wa_data-zbgamount = ls_entity-Zbgamount.
      wa_data-zbgissuancedate = ls_entity-Zbgissuancedate.
*      wa_data-zbgexpirydate = |{  ls_entity-Zbgexpirydate+6(2) }{  ls_entity-Zbgexpirydate+4(2) }{  ls_entity-Zbgexpirydate+0(4) }|.
      wa_data-zbgexpirydate = ls_entity-Zbgexpirydate.
      wa_data-zbgclaimdate = ls_entity-Zbgclaimdate.
      wa_data-zbgextupto = ls_entity-Zbgextupto.
      wa_data-bgclaimperiod = ls_entity-Bgclaimperiod.
      wa_data-zbgdaysextended = ls_entity-Zbgdaysextended.
      wa_data-zbgoverdue = ls_entity-Zbgoverdue.
      wa_data-zbgtennure = ls_entity-Zbgtennure.
      wa_data-zbgmargin = ls_entity-Zbgmargin.
      wa_data-zbgmarginamt = ls_entity-Zbgmarginamt.
      wa_data-zbgissuanceamt = ls_entity-Zbgissuanceamt.
      wa_data-zbgsfmsbgamt = ls_entity-Zbgsfmsbgamt.
      wa_data-zbgstampamt = ls_entity-Zbgstampamt.
      wa_data-zbggstamt = ls_entity-Zbggstamt.
      wa_data-zbgtotalchg = ls_entity-Zbgtotalchg.
      wa_data-zbgstatus = ls_entity-Zbgstatus.
      wa_data-zbgremarks = ls_entity-Zbgremarks.
      wa_data-Zcommrate = ls_entity-Zcommrate.
      wa_data-Zcommbasis = ls_entity-zcommbasis.
      wa_data-Zcommamount = ls_entity-zcommamount.
      wa_data-zgstcommamt = ls_entity-zgstcommamt.
      wa_data-Znitdate = ls_entity-znitdate.
      wa_data-Znitno = ls_entity-znitno.
      wa_data-Zbgtenuredays = ls_entity-Zbgtenuredays.
      wa_data-zcontractno = ls_entity-Zcontractno.
      wa_data-zcustomername = ls_entity-Zcustomername.
      wa_data-zbgextensionversion = ls_entity-Zbgextensionversion.
      wa_data-zbgclaimextensionversion = ls_entity-Zbgclaimextensionversion.
      wa_data-ztenderbenefic = ls_entity-Ztenderbenefic.
      wa_data-zendorsement = ls_entity-zendorsement.
      wa_data-zbankaddr = ls_entity-zbankaddr.
      wa_data-zbankifsc = ls_entity-zbankifsc.
      wa_data-zbankname = ls_entity-zbankname.
      wa_data-zcustomerbankaddr = ls_entity-zcustomerbankaddr.
      wa_data-zcustomerbankifsc = ls_entity-zcustomerbankifsc.
      wa_data-zcustomerbankname = ls_entity-zcustomerbankname.
      wa_data-zotheramount = ls_entity-zotheramount.
      wa_data-zotherrate = ls_entity-zotherrate.
      wa_data-zdms                = ls_entity-DMS.
      wa_data-zfile               = ls_entity-FileNo.
      wa_data-zmimetype           = ls_entity-MimeType.
      wa_data-zfilename           = ls_entity-FileName.
      wa_data-zonerous = ls_entity-zonerous.
      wa_data-flagcu = ls_entity-Flagcu.
      wa_data-flag = ls_entity-Flag.
      wa_data-createdon = cl_abap_context_info=>get_system_date( ).
      wa_data-createdat = cl_abap_context_info=>get_system_time( ).
      wa_data-createdby = cl_abap_context_info=>get_user_technical_name( ).

      "Edit
      IF wa_data-flag = 'X'.

        IF ls_entity-Zslno IS NOT INITIAL.

          wa_data-zslno =
            ls_entity-Zslno.


        ELSE.

          IF wa_data-zbgnumber IS NOT INITIAL.

            SELECT SINGLE *
              FROM zfi_customer_bg
              WHERE zbgnumber = @wa_data-zbgnumber
              INTO @ls_existing.

            IF sy-subrc = 0.

              wa_data-zslno = ls_existing-zslno.

              IF ls_existing-zbgextensionversion <>
                   wa_data-zbgextensionversion
                 OR
                 ls_existing-zbgclaimextensionversion <>
                   wa_data-zbgclaimextensionversion.

                APPEND ls_existing TO lhc_buffer=>mt_delete.

              ENDIF.

            ENDIF.

          ENDIF.

        ENDIF.

        IF wa_data-zslno IS INITIAL
           AND wa_data-zbgnumber IS NOT INITIAL.

          READ TABLE lhc_buffer=>mt_buffer
            INTO DATA(ls_existing_buffer)
            WITH KEY zbgnumber =
                     wa_data-zbgnumber.

          IF sy-subrc = 0.
            wa_data-zslno = ls_existing_buffer-zslno.
          ENDIF.

        ENDIF.

      ELSE.

        lv_date = wa_data-zbgissuancedate.

        IF lv_date IS INITIAL.
          lv_date = cl_abap_context_info=>get_system_date( ).
        ENDIF.

        lv_year = lv_date+0(4).

        lv_month = lv_date+4(2).

        IF lv_month >= 4.

          lv_fyear = lv_year.

        ELSE.

          lv_fyear =
            lv_year - 1.

        ENDIF.

        lv_pattern = |{ lc_prefix }{ wa_data-zprofitcenter }{ lv_fyear }%|.

        SELECT MAX( zslno )
          FROM zfi_customer_bg
          WHERE zprofitcenter = @wa_data-zprofitcenter
            AND zslno LIKE @lv_pattern
          INTO @lv_max_slno.

        IF lv_max_slno IS NOT INITIAL.
          DATA(lv_length) = strlen( lv_max_slno ).
          IF lv_length >= 4.
            DATA(lv_offset) = lv_length - 4.
            DATA(lv_serial_text) = lv_max_slno+lv_offset(4).
            lv_max_num = CONV numc4( lv_serial_text ).
          ENDIF.
        ENDIF.

        LOOP AT lhc_buffer=>mt_buffer
          INTO DATA(ls_buffer)
          WHERE zprofitcenter = wa_data-zprofitcenter.

          IF ls_buffer-zslno IS NOT INITIAL
             AND ls_buffer-zslno CP
                 |{ lc_prefix }{ wa_data-zprofitcenter }{ lv_fyear }*|.

            DATA(lv_buf_length) = strlen( ls_buffer-zslno ).

            IF lv_buf_length >= 4.

              DATA(lv_buf_offset) = lv_buf_length - 4.

              DATA(lv_buf_serial) = ls_buffer-zslno+lv_buf_offset(4).

              lv_buf_num = CONV numc4( lv_buf_serial ).

              IF lv_buf_num > lv_max_num.

                lv_max_num = lv_buf_num.

              ENDIF.

            ENDIF.

          ENDIF.

        ENDLOOP.

        lv_running = lv_max_num + 1.

        DO.

          wa_data-zslno = |{ lc_prefix }{ wa_data-zprofitcenter }{ lv_fyear }{ lv_running WIDTH = 4 PAD = '0' }|.

          SELECT SINGLE zslno
            FROM zfi_customer_bg
            WHERE zslno = @wa_data-zslno
            INTO @lv_existing_slno.

          IF sy-subrc = 0.
            lv_running = lv_running + 1.
            CLEAR lv_existing_slno.
            CONTINUE.
          ENDIF.

          READ TABLE lhc_buffer=>mt_buffer
            WITH KEY zslno = wa_data-zslno
            TRANSPORTING NO FIELDS.

          IF sy-subrc = 0.
            lv_running = lv_running + 1.
            CONTINUE.
          ENDIF.

          "Unique ZSLNO found
          EXIT.

        ENDDO.

      ENDIF.

      IF wa_data-flag = 'X'
         AND wa_data-zslno IS INITIAL.

        "Skip invalid edit request
        CONTINUE.

      ENDIF.

      APPEND wa_data TO lhc_buffer=>mt_buffer.

      APPEND VALUE #(
        %cid  = ls_entity-%cid
        Zslno = wa_data-zslno
      ) TO mapped-zfi_customer_bg_cds.

    ENDLOOP.
  ENDMETHOD.



  METHOD update.


    DATA:
      ls_data            TYPE zfi_customer_bg,
      ls_db              TYPE zfi_customer_bg,

      lv_version_changed TYPE abap_bool.


    LOOP AT entities INTO DATA(ls_entity).


      CLEAR:
        ls_data,
        ls_db,
        lv_version_changed.

      SELECT SINGLE *
        FROM zfi_customer_bg
        WHERE zslno = @ls_entity-Zslno
        INTO @ls_db.

      IF sy-subrc <> 0.

        CONTINUE.

      ENDIF.

      ls_data = ls_db.

      IF ls_entity-%control-Zbgextensionversion = if_abap_behv=>mk-on.
        IF ls_entity-Zbgextensionversion <>
             ls_db-zbgextensionversion.
          lv_version_changed = abap_true.
        ENDIF.
      ENDIF.

      IF ls_entity-%control-Zbgclaimextensionversion = if_abap_behv=>mk-on.
        IF ls_entity-Zbgclaimextensionversion <>
             ls_db-zbgclaimextensionversion.
          lv_version_changed = abap_true.
        ENDIF.
      ENDIF.

      IF ls_entity-%control-Zprofitcenter = if_abap_behv=>mk-on.
        ls_data-zprofitcenter = ls_entity-Zprofitcenter.
      ENDIF.

      IF ls_entity-%control-Zconcernperson = if_abap_behv=>mk-on.
        ls_data-zconcernperson = ls_entity-Zconcernperson.
      ENDIF.


      IF ls_entity-%control-Zjobnumber = if_abap_behv=>mk-on.
        ls_data-zjobnumber = ls_entity-Zjobnumber.
      ENDIF.


      IF ls_entity-%control-Zbeneficiarycode = if_abap_behv=>mk-on.
        ls_data-zbeneficiarycode = ls_entity-Zbeneficiarycode.
      ENDIF.


      IF ls_entity-%control-Zbeneficiaryname = if_abap_behv=>mk-on.
        ls_data-zbeneficiaryname = ls_entity-Zbeneficiaryname.
      ENDIF.


      IF ls_entity-%control-Zbgnumber = if_abap_behv=>mk-on.
        ls_data-zbgnumber = ls_entity-Zbgnumber.
      ENDIF.


      IF ls_entity-%control-Zbgpurpose = if_abap_behv=>mk-on.
        ls_data-zbgpurpose = ls_entity-Zbgpurpose.
      ENDIF.

      IF ls_entity-%control-Zbgtype = if_abap_behv=>mk-on.
        ls_data-zbgtype = ls_entity-Zbgtype.
      ENDIF.

      IF ls_entity-%control-Zbgamount = if_abap_behv=>mk-on.
        ls_data-zbgamount = ls_entity-Zbgamount.
      ENDIF.

      IF ls_entity-%control-Zbgissuancedate = if_abap_behv=>mk-on.
        ls_data-zbgissuancedate = ls_entity-Zbgissuancedate.
      ENDIF.

      IF ls_entity-%control-Zbgexpirydate = if_abap_behv=>mk-on.
        ls_data-zbgexpirydate = ls_entity-Zbgexpirydate.
      ENDIF.

      IF ls_entity-%control-Zbgclaimdate = if_abap_behv=>mk-on.
        ls_data-zbgclaimdate = ls_entity-Zbgclaimdate.
      ENDIF.

      IF ls_entity-%control-Zbgextupto = if_abap_behv=>mk-on.
        ls_data-zbgextupto = ls_entity-Zbgextupto.
      ENDIF.

      IF ls_entity-%control-Bgclaimperiod = if_abap_behv=>mk-on.
        ls_data-bgclaimperiod = ls_entity-Bgclaimperiod.
      ENDIF.

      IF ls_entity-%control-Zbgdaysextended = if_abap_behv=>mk-on.
        ls_data-zbgdaysextended = ls_entity-Zbgdaysextended.
      ENDIF.

      IF ls_entity-%control-Zbgoverdue = if_abap_behv=>mk-on.
        ls_data-zbgoverdue = ls_entity-Zbgoverdue.
      ENDIF.

      IF ls_entity-%control-Zbgtennure = if_abap_behv=>mk-on.
        ls_data-zbgtennure = ls_entity-Zbgtennure.
      ENDIF.

      IF ls_entity-%control-Zbgmargin = if_abap_behv=>mk-on.
        ls_data-zbgmargin = ls_entity-Zbgmargin.
      ENDIF.


      IF ls_entity-%control-Zbgmarginamt = if_abap_behv=>mk-on.
        ls_data-zbgmarginamt = ls_entity-Zbgmarginamt.
      ENDIF.

      IF ls_entity-%control-Zbgissuanceamt = if_abap_behv=>mk-on.
        ls_data-zbgissuanceamt = ls_entity-Zbgissuanceamt.
      ENDIF.

      IF ls_entity-%control-Zbgsfmsbgamt = if_abap_behv=>mk-on.
        ls_data-zbgsfmsbgamt = ls_entity-Zbgsfmsbgamt.
      ENDIF.

      IF ls_entity-%control-Zbgstampamt = if_abap_behv=>mk-on.
        ls_data-zbgstampamt = ls_entity-Zbgstampamt.
      ENDIF.

      IF ls_entity-%control-Zbggstamt = if_abap_behv=>mk-on.
        ls_data-zbggstamt = ls_entity-Zbggstamt.
      ENDIF.

      IF ls_entity-%control-Zbgtotalchg = if_abap_behv=>mk-on.
        ls_data-zbgtotalchg = ls_entity-Zbgtotalchg.
      ENDIF.

      IF ls_entity-%control-Zbgstatus = if_abap_behv=>mk-on.
        ls_data-zbgstatus = ls_entity-Zbgstatus.
      ENDIF.

      IF ls_entity-%control-Zbgremarks = if_abap_behv=>mk-on.
        ls_data-zbgremarks = ls_entity-Zbgremarks.
      ENDIF.

      IF ls_entity-%control-Zbgextensionversion = if_abap_behv=>mk-on.
        ls_data-zbgextensionversion = ls_entity-Zbgextensionversion.
      ENDIF.

      IF ls_entity-%control-Zbgclaimextensionversion = if_abap_behv=>mk-on.
        ls_data-zbgclaimextensionversion = ls_entity-Zbgclaimextensionversion.
      ENDIF.

      IF ls_entity-%control-Flagcu = if_abap_behv=>mk-on.
        ls_data-flagcu = ls_entity-Flagcu.
      ENDIF.

      IF ls_entity-%control-Flag = if_abap_behv=>mk-on.
        ls_data-flag = ls_entity-Flag.
      ENDIF.

      IF lv_version_changed = abap_true.

        APPEND ls_db TO lhc_buffer=>mt_delete.
        ls_data-zslno = ls_db-zslno.

      ELSE.

        ls_data-zslno = ls_db-zslno.
      ENDIF.

      APPEND ls_data TO lhc_buffer=>mt_buffer.

    ENDLOOP.
  ENDMETHOD.



  METHOD delete.
    LOOP AT keys INTO DATA(ls_key).

      SELECT SINGLE *
        FROM zfi_customer_bg
        WHERE zslno = @ls_key-Zslno
        INTO @DATA(ls_delete).

      IF sy-subrc = 0.
        APPEND ls_delete TO lhc_buffer=>mt_delete.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.



  METHOD read.
  ENDMETHOD.



  METHOD lock.
  ENDMETHOD.


ENDCLASS.



CLASS lsc_ZFI_CUSTOMER_BG_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.


    METHODS finalize
        REDEFINITION.


    METHODS check_before_save
        REDEFINITION.


    METHODS save
        REDEFINITION.


    METHODS cleanup
        REDEFINITION.


    METHODS cleanup_finalize
        REDEFINITION.


ENDCLASS.



CLASS lsc_ZFI_CUSTOMER_BG_CDS IMPLEMENTATION.


  METHOD finalize.
  ENDMETHOD.



  METHOD check_before_save.
  ENDMETHOD.


  METHOD save.
    LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer).

      SELECT SINGLE *
        FROM zfi_customer_bg
        WHERE zslno                    = @ls_buffer-zslno
          AND zbgextensionversion      = @ls_buffer-zbgextensionversion
          AND zbgclaimextensionversion = @ls_buffer-zbgclaimextensionversion
        INTO @DATA(ls_db).

      IF sy-subrc = 0.

        IF ls_buffer-zprofitcenter IS NOT INITIAL.
          ls_db-zprofitcenter = ls_buffer-zprofitcenter.
        ENDIF.

        IF ls_buffer-zconcernperson IS NOT INITIAL.
          ls_db-zconcernperson = ls_buffer-zconcernperson.
        ENDIF.

        IF ls_buffer-zjobnumber IS NOT INITIAL.
          ls_db-zjobnumber = ls_buffer-zjobnumber.
        ENDIF.

        IF ls_buffer-zbeneficiarycode IS NOT INITIAL.
          ls_db-zbeneficiarycode = ls_buffer-zbeneficiarycode.
        ENDIF.

        IF ls_buffer-zbeneficiaryname IS NOT INITIAL.
          ls_db-zbeneficiaryname = ls_buffer-zbeneficiaryname.
        ENDIF.

        IF ls_buffer-zbgnumber IS NOT INITIAL.
          ls_db-zbgnumber = ls_buffer-zbgnumber.
        ENDIF.

        IF ls_buffer-zbgpurpose IS NOT INITIAL.
          ls_db-zbgpurpose = ls_buffer-zbgpurpose.
        ENDIF.

        IF ls_buffer-zbgtype IS NOT INITIAL.
          ls_db-zbgtype = ls_buffer-zbgtype.
        ENDIF.

        IF ls_buffer-zbgamount IS NOT INITIAL.
          ls_db-zbgamount = ls_buffer-zbgamount.
        ENDIF.

        IF ls_buffer-zbgissuancedate IS NOT INITIAL.
          ls_db-zbgissuancedate = ls_buffer-zbgissuancedate.
        ENDIF.

        IF ls_buffer-zbgexpirydate IS NOT INITIAL.
          ls_db-zbgexpirydate = ls_buffer-zbgexpirydate.
        ENDIF.

        IF ls_buffer-zbgclaimdate IS NOT INITIAL.
          ls_db-zbgclaimdate = ls_buffer-zbgclaimdate.
        ENDIF.

        IF ls_buffer-zbgextupto IS NOT INITIAL.
          ls_db-zbgextupto = ls_buffer-zbgextupto.
        ENDIF.

        IF ls_buffer-bgclaimperiod IS NOT INITIAL.
          ls_db-bgclaimperiod = ls_buffer-bgclaimperiod.
        ENDIF.

        IF ls_buffer-zbgdaysextended IS NOT INITIAL.
          ls_db-zbgdaysextended = ls_buffer-zbgdaysextended.
        ENDIF.

        IF ls_buffer-zbgoverdue IS NOT INITIAL.
          ls_db-zbgoverdue = ls_buffer-zbgoverdue.
        ENDIF.

        IF ls_buffer-zbgtennure IS NOT INITIAL.
          ls_db-zbgtennure = ls_buffer-zbgtennure.
        ENDIF.

        IF ls_buffer-zbgmargin IS NOT INITIAL.
          ls_db-zbgmargin = ls_buffer-zbgmargin.
        ENDIF.

        IF ls_buffer-zbgmarginamt IS NOT INITIAL.
          ls_db-zbgmarginamt = ls_buffer-zbgmarginamt.
        ENDIF.

        IF ls_buffer-zbgissuanceamt IS NOT INITIAL.
          ls_db-zbgissuanceamt = ls_buffer-zbgissuanceamt.
        ENDIF.

        IF ls_buffer-zbgsfmsbgamt IS NOT INITIAL.
          ls_db-zbgsfmsbgamt = ls_buffer-zbgsfmsbgamt.
        ENDIF.

        IF ls_buffer-zbgstampamt IS NOT INITIAL.
          ls_db-zbgstampamt = ls_buffer-zbgstampamt.
        ENDIF.

        IF ls_buffer-zbggstamt IS NOT INITIAL.
          ls_db-zbggstamt = ls_buffer-zbggstamt.
        ENDIF.

        IF ls_buffer-zbgtotalchg IS NOT INITIAL.
          ls_db-zbgtotalchg = ls_buffer-zbgtotalchg.
        ENDIF.

        IF ls_buffer-zbgstatus IS NOT INITIAL.
          ls_db-zbgstatus = ls_buffer-zbgstatus.
        ENDIF.

        IF ls_buffer-zbgremarks IS NOT INITIAL.
          ls_db-zbgremarks = ls_buffer-zbgremarks.
        ENDIF.

        IF ls_buffer-flagcu IS NOT INITIAL.
          ls_db-flagcu = ls_buffer-flagcu.
        ENDIF.

        IF ls_buffer-flag IS NOT INITIAL.
          ls_db-flag = ls_buffer-flag.
        ENDIF.

        MODIFY zfi_customer_bg FROM @ls_db.

      ELSE.

        INSERT zfi_customer_bg FROM @ls_buffer.

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
