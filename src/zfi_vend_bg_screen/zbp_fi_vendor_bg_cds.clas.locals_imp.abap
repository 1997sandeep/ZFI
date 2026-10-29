CLASS lhc_buffer DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_vendor_bg.

    CLASS-DATA mt_delete TYPE STANDARD TABLE OF zfi_vendor_bg.

ENDCLASS.


CLASS lhc_ZFI_VENDOR_BG_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    CONSTANTS lc_prefix TYPE char3 VALUE 'AP-'.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations
      FOR zfi_vendor_bg_cds RESULT result.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations
      FOR zfi_vendor_bg_cds RESULT result.

    METHODS create
      FOR MODIFY
      IMPORTING entities FOR CREATE zfi_vendor_bg_cds.

    METHODS update
      FOR MODIFY
      IMPORTING entities FOR UPDATE zfi_vendor_bg_cds.

    METHODS delete
      FOR MODIFY
      IMPORTING keys FOR DELETE zfi_vendor_bg_cds.

    METHODS read
      FOR READ
      IMPORTING keys FOR READ zfi_vendor_bg_cds RESULT result.

    METHODS lock
      FOR LOCK
      IMPORTING keys FOR LOCK zfi_vendor_bg_cds.

ENDCLASS.


CLASS lhc_ZFI_VENDOR_BG_CDS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD create.

    DATA:
      wa_data          TYPE zfi_vendor_bg,
      ls_existing      TYPE zfi_vendor_bg,
      lv_max_num       TYPE numc4,
      lv_running       TYPE numc4,
      lv_fyear         TYPE numc4,
      lv_pattern       TYPE string,
      lv_max_doc       TYPE zfi_vendor_bg-zdocumentnumber,
      lv_existing_doc  TYPE zfi_vendor_bg-zdocumentnumber,
      lv_date          TYPE d,
      lv_year          TYPE i,
      lv_month         TYPE i,
      lv_length        TYPE i,
      lv_offset         TYPE i,
      lv_serial_text   TYPE string,
      lv_buf_length    TYPE i,
      lv_buf_offset    TYPE i,
      lv_buf_serial    TYPE string,
      lv_buf_num       TYPE numc4.

    LOOP AT entities INTO DATA(ls_entity).

    IF ls_entity-Zbgamount IS INITIAL.

    APPEND VALUE #(
      %tky = ls_entity-%key
    ) TO failed-zfi_vendor_bg_cds.

    APPEND VALUE #(
      %tky = ls_entity-%key
      %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = |Please maintain BG amount|
      )
      %element-Zbgamount = if_abap_behv=>mk-on
    ) TO reported-zfi_vendor_bg_cds.

    RETURN.

  ENDIF.
  IF ls_entity-Zclaimenddate IS INITIAL.

    APPEND VALUE #(
      %tky = ls_entity-%key
    ) TO failed-zfi_vendor_bg_cds.

    APPEND VALUE #(
      %tky = ls_entity-%key
      %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = |Please maintain BG Claim Date|
      )
      %element-Zbgamount = if_abap_behv=>mk-on
    ) TO reported-zfi_vendor_bg_cds.

    RETURN.

  ENDIF.
  IF ls_entity-Zbgexpirydate IS INITIAL.

    APPEND VALUE #(
      %tky = ls_entity-%key
    ) TO failed-zfi_vendor_bg_cds.

    APPEND VALUE #(
      %tky = ls_entity-%key
      %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = |Please maintain BG Expiry Date|
      )
      %element-Zbgamount = if_abap_behv=>mk-on
    ) TO reported-zfi_vendor_bg_cds.

    RETURN.

  ENDIF.
  IF ls_entity-Zbgissuedate IS INITIAL.

    APPEND VALUE #(
      %tky = ls_entity-%key
    ) TO failed-zfi_vendor_bg_cds.

    APPEND VALUE #(
      %tky = ls_entity-%key
      %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text     = |Please maintain BG Issuance Date|
      )
      %element-Zbgamount = if_abap_behv=>mk-on
    ) TO reported-zfi_vendor_bg_cds.

    RETURN.

  ENDIF.


      CLEAR:
        wa_data,
        ls_existing,
        lv_max_num,
        lv_running,
        lv_fyear,
        lv_pattern,
        lv_max_doc,
        lv_existing_doc,
        lv_date,
        lv_year,
        lv_month,
        lv_length,
        lv_offset,
        lv_serial_text,
        lv_buf_length,
        lv_buf_offset,
        lv_buf_serial,
        lv_buf_num.

      wa_data-zprofitcenter            = ls_entity-Zprofitcenter.
      wa_data-zbgtransactiontype       = ls_entity-Zbgtransactiontype.
      wa_data-zbgnumber                = ls_entity-Zbgnumber.
      wa_data-zbgdate                  = ls_entity-Zbgdate.
      wa_data-zbgexpirydate            = ls_entity-Zbgexpirydate.
      wa_data-zprojectid               = ls_entity-Zprojectid.
      wa_data-zcreatedon               = ls_entity-Zcreatedon.

      wa_data-zbgamount                = ls_entity-Zbgamount.
      wa_data-zcurrency                = ls_entity-Zcurrency.
      wa_data-zbgissuedate             = ls_entity-Zbgissuedate.
      wa_data-zbgtype                  = ls_entity-Zbgtype.
      wa_data-zbgpurpose               = ls_entity-Zbgpurpose.
      wa_data-zclaimenddate            = ls_entity-Zclaimenddate.
      wa_data-zbgextensiondate         = ls_entity-Zbgextensiondate.
      wa_data-zbgextensionversion      = ls_entity-Zbgextensionversion.

      wa_data-zbillingamount           = ls_entity-Zbillingamount.
      wa_data-zpurchaseorder           = ls_entity-Zpurchaseorder.
      wa_data-zbankifsc                = ls_entity-Zbankifsc.
      wa_data-zbankname                = ls_entity-Zbankname.
      wa_data-zbankaddr                = ls_entity-Zbankaddr.
      wa_data-zdocumentstatus          = ls_entity-Zdocumentstatus.
      wa_data-zdaysexpire              = ls_entity-Zdaysexpire.

      wa_data-zvendor                  = ls_entity-Zvendor.
      wa_data-zvendorname              = ls_entity-Zvendorname.
      wa_data-zvendoraddr              = ls_entity-Zvendoraddr.

      wa_data-zbdemdconfirmbank        = ls_entity-Zbdemdconfirmbank.
      wa_data-zbdemdconfirmdate        = ls_entity-Zbdemdconfirmdate.
      wa_data-zpaymentreceiveddate     = ls_entity-Zpaymentreceiveddate.
      wa_data-zbgdischargeddate        = ls_entity-Zbgdischargeddate.

      wa_data-zbgtenure                = ls_entity-Zbgtenure.
*      a_data-zbgmargin = ls_entity-Zbgmargin.
      wa_data-zbgmarginamt = ls_entity-Zbgmarginamt.
      wa_data-Zcommrate = ls_entity-Zcommrate.
      wa_data-Zcommbasis = ls_entity-zcommbasis.
      wa_data-Zcommamount = ls_entity-zcommamount.
      wa_data-zremark = ls_entity-zremark.
      wa_data-zbgtenuredays = ls_entity-zbgtenuredays.
      wa_data-zvendorbankaddr = ls_entity-Zbgtenuredays.
      wa_data-zvendorbankifsc = ls_entity-zvendorbankifsc.
      wa_data-zvendorbankname = ls_entity-zvendorbankname.
      wa_data-zgstcommamt = ls_entity-zgstcommamt.
      wa_data-ztotcommamt = ls_entity-Ztotcommamt.
         wa_data-zotheramount = ls_entity-zotheramount.

          wa_data-zdms                = ls_entity-DMS.
      wa_data-zfile               = ls_entity-FileNo.
      wa_data-zmimetype           = ls_entity-MimeType.
      wa_data-zfilename           = ls_entity-FileName.

      wa_data-zbgclaimextensiondate    = ls_entity-Zbgclaimextensiondate.
      wa_data-zbgclaimextensionversion = ls_entity-Zbgclaimextensionversion.

      wa_data-flagcu                   = ls_entity-Flagcu.
      wa_data-flag                     = ls_entity-Flag.

      wa_data-createdon = cl_abap_context_info=>get_system_date( ).

      wa_data-createdat = cl_abap_context_info=>get_system_time( ).

      wa_data-createdby = cl_abap_context_info=>get_user_technical_name( ).

      "Edit
      IF ls_entity-Flag = 'X'.

        IF ls_entity-Zdocumentnumber IS NOT INITIAL.
          wa_data-zdocumentnumber = ls_entity-Zdocumentnumber.
        ELSE.

          IF wa_data-zbgnumber IS NOT INITIAL.

            SELECT MAX( zdocumentnumber )
              FROM zfi_vendor_bg
              WHERE zbgnumber = @wa_data-zbgnumber
              INTO @lv_existing_doc.

            IF sy-subrc = 0
               AND lv_existing_doc IS NOT INITIAL.

              wa_data-zdocumentnumber =
                lv_existing_doc.

            ENDIF.

          ENDIF.

        ENDIF.

        IF wa_data-zdocumentnumber IS INITIAL AND wa_data-zbgnumber IS NOT INITIAL.

          READ TABLE lhc_buffer=>mt_buffer
            INTO DATA(ls_buffer_edit)
            WITH KEY zbgnumber = wa_data-zbgnumber.
          IF sy-subrc = 0.
            wa_data-zdocumentnumber = ls_buffer_edit-zdocumentnumber.
          ENDIF.

        ENDIF.

        IF wa_data-zdocumentnumber IS NOT INITIAL.

          SELECT SINGLE *
            FROM zfi_vendor_bg
            WHERE zdocumentnumber = @wa_data-zdocumentnumber
              AND zbgextensionversion = @wa_data-zbgextensionversion
              AND zbgclaimextensionversion = @wa_data-zbgclaimextensionversion
            INTO @ls_existing.

          IF sy-subrc <> 0.

            SELECT SINGLE *
              FROM zfi_vendor_bg
              WHERE zdocumentnumber = @wa_data-zdocumentnumber
              INTO @ls_existing.

          ENDIF.


          IF sy-subrc = 0.

            IF ls_existing-zbgextensionversion <>
                 wa_data-zbgextensionversion
               OR
               ls_existing-zbgclaimextensionversion <>
                 wa_data-zbgclaimextensionversion.

              APPEND ls_existing TO lhc_buffer=>mt_delete.

            ENDIF.

          ENDIF.

        ENDIF.

        IF wa_data-zdocumentnumber IS INITIAL.

          CONTINUE.

        ENDIF.

      ELSE.

        lv_date = wa_data-zcreatedon.

        IF lv_date IS INITIAL.
          lv_date = cl_abap_context_info=>get_system_date( ).
        ENDIF.


        lv_year = lv_date+0(4).

        lv_month = lv_date+4(2).


        "Fiscal year April to March
        IF lv_month >= 4.
          lv_fyear = lv_year.
        ELSE.
          lv_fyear = lv_year - 1.
        ENDIF.

        lv_pattern = |{ lc_prefix }{ wa_data-zprofitcenter }{ lv_fyear }%|.

        SELECT MAX( zdocumentnumber )
          FROM zfi_vendor_bg
          WHERE zprofitcenter = @wa_data-zprofitcenter
            AND zdocumentnumber LIKE @lv_pattern
          INTO @lv_max_doc.

        IF lv_max_doc IS NOT INITIAL.

          lv_length = strlen( lv_max_doc ).
          IF lv_length >= 4.

            lv_offset = lv_length - 4.
            lv_serial_text = lv_max_doc+lv_offset(4).
            lv_max_num = CONV numc4( lv_serial_text ).

          ENDIF.

        ENDIF.

        LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer) WHERE zprofitcenter = wa_data-zprofitcenter.

        IF ls_buffer-zdocumentnumber IS NOT INITIAL.
         lv_buf_length = strlen( ls_buffer-zdocumentnumber ).

        IF lv_buf_length >= 4.

        lv_buf_offset = lv_buf_length - 4.
        lv_buf_serial = ls_buffer-zdocumentnumber+lv_buf_offset(4).

        lv_buf_num = CONV numc4( lv_buf_serial ).
        IF lv_buf_num > lv_max_num.

        lv_max_num = lv_buf_num.

          ENDIF.

         ENDIF.

        ENDIF.

       ENDLOOP.

        lv_running = lv_max_num + 1.

        DO.
          wa_data-zdocumentnumber = |{ lc_prefix }{ wa_data-zprofitcenter }{ lv_fyear }{ lv_running WIDTH = 4 PAD = '0' }|.

          SELECT SINGLE zdocumentnumber
            FROM zfi_vendor_bg
            WHERE zdocumentnumber = @wa_data-zdocumentnumber
            INTO @lv_existing_doc.

          IF sy-subrc = 0.

            lv_running = lv_running + 1.

            CLEAR lv_existing_doc.

            CONTINUE.

          ENDIF.


          READ TABLE lhc_buffer=>mt_buffer
            WITH KEY zdocumentnumber = wa_data-zdocumentnumber TRANSPORTING NO FIELDS.

          IF sy-subrc = 0.

            lv_running = lv_running + 1.

            CONTINUE.

          ENDIF.


          EXIT.

        ENDDO.

      ENDIF.

      APPEND wa_data TO lhc_buffer=>mt_buffer.

      APPEND VALUE #(
        %cid            = ls_entity-%cid
        Zdocumentnumber = wa_data-zdocumentnumber
      ) TO mapped-zfi_vendor_bg_cds.


    ENDLOOP.

  ENDMETHOD.


  METHOD update.

    DATA:
      ls_data            TYPE zfi_vendor_bg,
      ls_db              TYPE zfi_vendor_bg,
      lv_version_changed TYPE abap_bool.


    LOOP AT entities INTO DATA(ls_entity).

      CLEAR:
        ls_data,
        ls_db,
        lv_version_changed.

      SELECT SINGLE *
        FROM zfi_vendor_bg
        WHERE zdocumentnumber = @ls_entity-Zdocumentnumber
        INTO @ls_db.

      IF sy-subrc <> 0.

        CONTINUE.

      ENDIF.

      ls_data = ls_db.

      IF ls_entity-%control-Zbgextensionversion = if_abap_behv=>mk-on.
        IF ls_entity-Zbgextensionversion <> ls_db-zbgextensionversion.
          lv_version_changed = abap_true.
        ENDIF.
      ENDIF.

      IF ls_entity-%control-Zbgclaimextensionversion = if_abap_behv=>mk-on.
        IF ls_entity-Zbgclaimextensionversion <> ls_db-zbgclaimextensionversion.
          lv_version_changed = abap_true.
        ENDIF.
      ENDIF.

      IF ls_entity-%control-Zprofitcenter = if_abap_behv=>mk-on.
        ls_data-zprofitcenter = ls_entity-Zprofitcenter.
      ENDIF.

      IF ls_entity-%control-Zbgtransactiontype = if_abap_behv=>mk-on.
        ls_data-zbgtransactiontype = ls_entity-Zbgtransactiontype.
      ENDIF.

      IF ls_entity-%control-Zbgnumber = if_abap_behv=>mk-on.
        ls_data-zbgnumber = ls_entity-Zbgnumber.
      ENDIF.

      IF ls_entity-%control-Zbgdate = if_abap_behv=>mk-on.
        ls_data-zbgdate = ls_entity-Zbgdate.
      ENDIF.

      IF ls_entity-%control-Zbgexpirydate = if_abap_behv=>mk-on.
        ls_data-zbgexpirydate = ls_entity-Zbgexpirydate.
      ENDIF.

      IF ls_entity-%control-Zprojectid = if_abap_behv=>mk-on.
        ls_data-zprojectid = ls_entity-Zprojectid.
      ENDIF.

      IF ls_entity-%control-Zcreatedon = if_abap_behv=>mk-on.
        ls_data-zcreatedon = ls_entity-Zcreatedon.
      ENDIF.

      IF ls_entity-%control-Zbgamount = if_abap_behv=>mk-on.
        ls_data-zbgamount = ls_entity-Zbgamount.
      ENDIF.

      IF ls_entity-%control-Zcurrency = if_abap_behv=>mk-on.
        ls_data-zcurrency = ls_entity-Zcurrency.
      ENDIF.

      IF ls_entity-%control-Zbgissuedate = if_abap_behv=>mk-on.
        ls_data-zbgissuedate = ls_entity-Zbgissuedate.
      ENDIF.

      IF ls_entity-%control-Zbgtype = if_abap_behv=>mk-on.
        ls_data-zbgtype = ls_entity-Zbgtype.
      ENDIF.

      IF ls_entity-%control-Zbgpurpose = if_abap_behv=>mk-on.
        ls_data-zbgpurpose = ls_entity-Zbgpurpose.
      ENDIF.

      IF ls_entity-%control-Zclaimenddate = if_abap_behv=>mk-on.
        ls_data-zclaimenddate = ls_entity-Zclaimenddate.
      ENDIF.

      IF ls_entity-%control-Zbgextensiondate = if_abap_behv=>mk-on.
        ls_data-zbgextensiondate = ls_entity-Zbgextensiondate.
      ENDIF.

      IF ls_entity-%control-Zbgextensionversion = if_abap_behv=>mk-on.
        ls_data-zbgextensionversion = ls_entity-Zbgextensionversion.
      ENDIF.

      IF ls_entity-%control-Zbillingamount = if_abap_behv=>mk-on.
        ls_data-zbillingamount = ls_entity-Zbillingamount.
      ENDIF.

      IF ls_entity-%control-Zpurchaseorder = if_abap_behv=>mk-on.
        ls_data-zpurchaseorder = ls_entity-Zpurchaseorder.
      ENDIF.

      IF ls_entity-%control-Zbankifsc = if_abap_behv=>mk-on.
        ls_data-zbankifsc = ls_entity-Zbankifsc.
      ENDIF.

      IF ls_entity-%control-Zbankname = if_abap_behv=>mk-on.
        ls_data-zbankname = ls_entity-Zbankname.
      ENDIF.

      IF ls_entity-%control-Zbankaddr = if_abap_behv=>mk-on.
        ls_data-zbankaddr = ls_entity-Zbankaddr.
      ENDIF.

      IF ls_entity-%control-Zdocumentstatus = if_abap_behv=>mk-on.
        ls_data-zdocumentstatus = ls_entity-Zdocumentstatus.
      ENDIF.

      IF ls_entity-%control-Zdaysexpire = if_abap_behv=>mk-on.
        ls_data-zdaysexpire = ls_entity-Zdaysexpire.
      ENDIF.

      IF ls_entity-%control-Zvendor = if_abap_behv=>mk-on.
        ls_data-zvendor = ls_entity-Zvendor.
      ENDIF.

      IF ls_entity-%control-Zvendorname = if_abap_behv=>mk-on.
        ls_data-zvendorname = ls_entity-Zvendorname.
      ENDIF.

      IF ls_entity-%control-Zvendoraddr = if_abap_behv=>mk-on.
        ls_data-zvendoraddr = ls_entity-Zvendoraddr.
      ENDIF.

      IF ls_entity-%control-Zbdemdconfirmbank = if_abap_behv=>mk-on.
        ls_data-zbdemdconfirmbank = ls_entity-Zbdemdconfirmbank.
      ENDIF.

      IF ls_entity-%control-Zbdemdconfirmdate = if_abap_behv=>mk-on.
        ls_data-zbdemdconfirmdate = ls_entity-Zbdemdconfirmdate.
      ENDIF.

      IF ls_entity-%control-Zpaymentreceiveddate = if_abap_behv=>mk-on.
        ls_data-zpaymentreceiveddate = ls_entity-Zpaymentreceiveddate.
      ENDIF.

      IF ls_entity-%control-Zbgdischargeddate = if_abap_behv=>mk-on.
        ls_data-zbgdischargeddate = ls_entity-Zbgdischargeddate.
      ENDIF.

      IF ls_entity-%control-Zbgtenure = if_abap_behv=>mk-on.
        ls_data-zbgtenure = ls_entity-Zbgtenure.
      ENDIF.

      IF ls_entity-%control-Zbgclaimextensiondate = if_abap_behv=>mk-on.
        ls_data-zbgclaimextensiondate = ls_entity-Zbgclaimextensiondate.
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

      IF lv_version_changed = abap_true AND ls_entity-Flag = 'X'.

        APPEND ls_db TO lhc_buffer=>mt_delete.

        ls_data-zdocumentnumber = ls_db-zdocumentnumber.

      ELSE.

        ls_data-zdocumentnumber = ls_db-zdocumentnumber.

      ENDIF.

      APPEND ls_data TO lhc_buffer=>mt_buffer.

    ENDLOOP.
  ENDMETHOD.

  METHOD delete.

    LOOP AT keys INTO DATA(ls_key).

      SELECT SINGLE *
        FROM zfi_vendor_bg
        WHERE zdocumentnumber = @ls_key-Zdocumentnumber
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


CLASS lsc_ZFI_VENDOR_BG_CDS DEFINITION
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


CLASS lsc_ZFI_VENDOR_BG_CDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.


  METHOD check_before_save.
  ENDMETHOD.


METHOD save.

  LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer).

    SELECT SINGLE *
      FROM zfi_vendor_bg
      WHERE zdocumentnumber          = @ls_buffer-zdocumentnumber
        AND zbgextensionversion      = @ls_buffer-zbgextensionversion
        AND zbgclaimextensionversion = @ls_buffer-zbgclaimextensionversion
      INTO @DATA(ls_db).

    IF sy-subrc = 0.

      IF ls_buffer-zprofitcenter IS NOT INITIAL.
        ls_db-zprofitcenter = ls_buffer-zprofitcenter.
      ENDIF.

      IF ls_buffer-zbgtransactiontype IS NOT INITIAL.
        ls_db-zbgtransactiontype = ls_buffer-zbgtransactiontype.
      ENDIF.

      IF ls_buffer-zbgnumber IS NOT INITIAL.
        ls_db-zbgnumber = ls_buffer-zbgnumber.
      ENDIF.

      IF ls_buffer-zbgdate IS NOT INITIAL.
        ls_db-zbgdate = ls_buffer-zbgdate.
      ENDIF.

      IF ls_buffer-zbgexpirydate IS NOT INITIAL.
        ls_db-zbgexpirydate = ls_buffer-zbgexpirydate.
      ENDIF.

      IF ls_buffer-zprojectid IS NOT INITIAL.
        ls_db-zprojectid = ls_buffer-zprojectid.
      ENDIF.

      IF ls_buffer-zcreatedon IS NOT INITIAL.
        ls_db-zcreatedon = ls_buffer-zcreatedon.
      ENDIF.

      IF ls_buffer-zbgamount IS NOT INITIAL.
        ls_db-zbgamount = ls_buffer-zbgamount.
      ENDIF.

      IF ls_buffer-zcurrency IS NOT INITIAL.
        ls_db-zcurrency = ls_buffer-zcurrency.
      ENDIF.

      IF ls_buffer-zbgissuedate IS NOT INITIAL.
        ls_db-zbgissuedate = ls_buffer-zbgissuedate.
      ENDIF.

      IF ls_buffer-zbgtype IS NOT INITIAL.
        ls_db-zbgtype = ls_buffer-zbgtype.
      ENDIF.

      IF ls_buffer-zbgpurpose IS NOT INITIAL.
        ls_db-zbgpurpose = ls_buffer-zbgpurpose.
      ENDIF.

      IF ls_buffer-zclaimenddate IS NOT INITIAL.
        ls_db-zclaimenddate = ls_buffer-zclaimenddate.
      ENDIF.

      IF ls_buffer-zbgextensiondate IS NOT INITIAL.
        ls_db-zbgextensiondate = ls_buffer-zbgextensiondate.
      ENDIF.

      IF ls_buffer-zbillingamount IS NOT INITIAL.
        ls_db-zbillingamount = ls_buffer-zbillingamount.
      ENDIF.

      IF ls_buffer-zpurchaseorder IS NOT INITIAL.
        ls_db-zpurchaseorder = ls_buffer-zpurchaseorder.
      ENDIF.

      IF ls_buffer-zbankifsc IS NOT INITIAL.
        ls_db-zbankifsc = ls_buffer-zbankifsc.
      ENDIF.

      IF ls_buffer-zbankname IS NOT INITIAL.
        ls_db-zbankname = ls_buffer-zbankname.
      ENDIF.

      IF ls_buffer-zbankaddr IS NOT INITIAL.
        ls_db-zbankaddr = ls_buffer-zbankaddr.
      ENDIF.

      IF ls_buffer-zdocumentstatus IS NOT INITIAL.
        ls_db-zdocumentstatus = ls_buffer-zdocumentstatus.
      ENDIF.

      IF ls_buffer-zdaysexpire IS NOT INITIAL.
        ls_db-zdaysexpire = ls_buffer-zdaysexpire.
      ENDIF.

      IF ls_buffer-zvendor IS NOT INITIAL.
        ls_db-zvendor = ls_buffer-zvendor.
      ENDIF.

      IF ls_buffer-zvendorname IS NOT INITIAL.
        ls_db-zvendorname = ls_buffer-zvendorname.
      ENDIF.

      IF ls_buffer-zvendoraddr IS NOT INITIAL.
        ls_db-zvendoraddr = ls_buffer-zvendoraddr.
      ENDIF.

      IF ls_buffer-zbdemdconfirmbank IS NOT INITIAL.
        ls_db-zbdemdconfirmbank = ls_buffer-zbdemdconfirmbank.
      ENDIF.

      IF ls_buffer-zbdemdconfirmdate IS NOT INITIAL.
        ls_db-zbdemdconfirmdate = ls_buffer-zbdemdconfirmdate.
      ENDIF.

      IF ls_buffer-zpaymentreceiveddate IS NOT INITIAL.
        ls_db-zpaymentreceiveddate = ls_buffer-zpaymentreceiveddate.
      ENDIF.

      IF ls_buffer-zbgdischargeddate IS NOT INITIAL.
        ls_db-zbgdischargeddate = ls_buffer-zbgdischargeddate.
      ENDIF.

      IF ls_buffer-zbgtenure IS NOT INITIAL.
        ls_db-zbgtenure = ls_buffer-zbgtenure.
      ENDIF.

      IF ls_buffer-zbgclaimextensiondate IS NOT INITIAL.
        ls_db-zbgclaimextensiondate = ls_buffer-zbgclaimextensiondate.
      ENDIF.

      IF ls_buffer-flagcu IS NOT INITIAL.
        ls_db-flagcu = ls_buffer-flagcu.
      ENDIF.

      IF ls_buffer-flag IS NOT INITIAL.
        ls_db-flag = ls_buffer-flag.
      ENDIF.

      MODIFY zfi_vendor_bg FROM @ls_db.

    ELSE.

      INSERT zfi_vendor_bg FROM @ls_buffer.

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

