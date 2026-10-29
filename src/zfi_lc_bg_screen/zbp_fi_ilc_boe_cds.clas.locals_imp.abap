CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.
    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_ilc_boe.

    CLASS-DATA mt_delete TYPE STANDARD TABLE OF zfi_ilc_boe.
ENDCLASS.

CLASS lhc_ZFI_ILC_BOE_CDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zfi_ilc_boe_cds RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zfi_ilc_boe_cds RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE zfi_ilc_boe_cds.

    METHODS update FOR MODIFY
       entities FOR UPDATE zfi_ilc_boe_cds.

    METHODS delete FOR MODIFY
       keys FOR DELETE zfi_ilc_boe_cds.

    METHODS read FOR READ
       keys FOR READ zfi_ilc_boe_cds RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK zfi_ilc_boe_cds.

ENDCLASS.

CLASS lhc_ZFI_ILC_BOE_CDS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

  DATA:
    wa_data TYPE zfi_ilc_boe.

  LOOP AT entities INTO DATA(ls_entity).

    CLEAR wa_data.

    SELECT SINGLE lc_number
      FROM zfi_inward_lc
      WHERE lc_number = @ls_entity-LcNumber
      INTO @DATA(lv_lc_number).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %cid = ls_entity-%cid
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'Invalid LC Number. LC does not exist in Inward LC Master.'
               )
      ) TO reported-zfi_ilc_boe_cds.

      CONTINUE.

    ENDIF.

    wa_data-boe_ref_number  = ls_entity-BoeRefNumber.
    wa_data-boe_type        = ls_entity-BoeType.

*   LC Number comes from ZFI_INWARD_LC
    wa_data-lc_number       = lv_lc_number.

    wa_data-drawee_name     = ls_entity-DraweeName.
    wa_data-drawer_name     = ls_entity-DrawerName.

    wa_data-drawee_desc     = ls_entity-DraweeDesc.
    wa_data-drawer_desc     = ls_entity-DrawerDesc.

    wa_data-booking_date    = ls_entity-BookingDate.
    wa_data-applicable_date = ls_entity-ApplicableDate.
    wa_data-maturity_date   = ls_entity-MaturityDate.
    wa_data-boe_amount      = ls_entity-BoeAmount.
    wa_data-currency        = ls_entity-Currency.
    wa_data-order_number    = ls_entity-OrderNumber.

    wa_data-descrepencies   = ls_entity-Descrepencies.

    wa_data-createdon =
      cl_abap_context_info=>get_system_date( ).

    wa_data-createdat =
      cl_abap_context_info=>get_system_time( ).

    wa_data-createdby =
      cl_abap_context_info=>get_user_technical_name( ).

    APPEND wa_data TO lhc_buffer=>mt_buffer.

    APPEND VALUE #(
      %cid         = ls_entity-%cid
      BoeRefNumber = wa_data-boe_ref_number
    ) TO mapped-zfi_ilc_boe_cds.

  ENDLOOP.

  ENDMETHOD.

  METHOD update.

  LOOP AT entities INTO DATA(ls_entity).

    SELECT SINGLE *
      FROM zfi_ilc_boe
      WHERE boe_ref_number = @ls_entity-BoeRefNumber
      INTO @DATA(ls_data).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_entity-%tky
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'BOE record not found.'
               )
      ) TO reported-zfi_ilc_boe_cds.

      CONTINUE.

    ENDIF.

    ls_data-lc_number = ls_data-lc_number.

    IF ls_entity-%control-BoeType = if_abap_behv=>mk-on.

      ls_data-boe_type = ls_entity-BoeType.

    ENDIF.

    IF ls_entity-%control-DraweeName = if_abap_behv=>mk-on.

      ls_data-drawee_name = ls_entity-DraweeName.

    ENDIF.

    IF ls_entity-%control-DrawerDesc = if_abap_behv=>mk-on.

      ls_data-drawer_desc = ls_entity-DrawerDesc.

    ENDIF.

    IF ls_entity-%control-DraweeDesc = if_abap_behv=>mk-on.

      ls_data-drawee_desc = ls_entity-DraweeDesc.

    ENDIF.

    IF ls_entity-%control-DrawerName = if_abap_behv=>mk-on.

      ls_data-drawer_name = ls_entity-DrawerName.

    ENDIF.

    IF ls_entity-%control-BookingDate = if_abap_behv=>mk-on.

      ls_data-booking_date = ls_entity-BookingDate.

    ENDIF.

    IF ls_entity-%control-ApplicableDate = if_abap_behv=>mk-on.

      ls_data-applicable_date = ls_entity-ApplicableDate.

    ENDIF.

    IF ls_entity-%control-MaturityDate = if_abap_behv=>mk-on.

      ls_data-maturity_date = ls_entity-MaturityDate.

    ENDIF.

    IF ls_entity-%control-BoeAmount = if_abap_behv=>mk-on.

      ls_data-boe_amount = ls_entity-BoeAmount.

    ENDIF.


    IF ls_entity-%control-Currency = if_abap_behv=>mk-on.

      ls_data-currency = ls_entity-Currency.

    ENDIF.

    IF ls_entity-%control-OrderNumber = if_abap_behv=>mk-on.

      ls_data-order_number = ls_entity-OrderNumber.

    ENDIF.


    IF ls_entity-%control-Descrepencies = if_abap_behv=>mk-on.

      ls_data-descrepencies = ls_entity-Descrepencies.

    ENDIF.

    APPEND ls_data TO lhc_buffer=>mt_buffer.

  ENDLOOP.

 ENDMETHOD.


  METHOD delete.

  LOOP AT keys INTO DATA(ls_key).

    APPEND VALUE #(
      boe_ref_number = ls_key-BoeRefNumber
    ) TO lhc_buffer=>mt_delete.

  ENDLOOP.

ENDMETHOD.

*  METHOD read.
*  ENDMETHOD.
  METHOD read.

    LOOP AT keys INTO DATA(ls_key).

      SELECT SINGLE
        FROM zfi_ilc_boe
        FIELDS
          boe_ref_number,
          boe_type,
          lc_number,
          drawee_name,
          drawer_name,
          drawee_desc,
          drawer_desc,
          booking_date,
          applicable_date,
          maturity_date,
          boe_amount,
          currency,
          order_number,
          descrepencies,
          createdon,
          createdat,
          createdby
        WHERE boe_ref_number = @ls_key-BoeRefNumber
        INTO @DATA(ls_data).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky              = ls_key-%tky
          BoeRefNumber      = ls_data-boe_ref_number
          BoeType           = ls_data-boe_type
          LcNumber          = ls_data-lc_number
          DraweeName        = ls_data-drawee_name
          DrawerName        = ls_data-drawer_name
          DraweeDesc        = ls_data-drawee_desc
          DrawerDesc        = ls_data-drawer_desc
          BookingDate       = ls_data-booking_date
          ApplicableDate    = ls_data-applicable_date
          MaturityDate      = ls_data-maturity_date
          BoeAmount         = ls_data-boe_amount
          Currency          = ls_data-currency
          OrderNumber       = ls_data-order_number
          Descrepencies     = ls_data-descrepencies
          CreatedOn         = ls_data-createdon
          CreatedAt         = ls_data-createdat
          CreatedBy         = ls_data-createdby
        ) TO result.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZFI_ILC_BOE_CDS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZFI_ILC_BOE_CDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

 METHOD save.

  IF lhc_buffer=>mt_delete IS NOT INITIAL.

    LOOP AT lhc_buffer=>mt_delete INTO DATA(ls_delete).
      DELETE FROM zfi_ilc_boe WHERE boe_ref_number = @ls_delete-boe_ref_number.
    ENDLOOP.

    LOOP AT lhc_buffer=>mt_delete INTO DATA(ls_del_buf).
      DELETE lhc_buffer=>mt_buffer WHERE boe_ref_number = ls_del_buf-boe_ref_number.
    ENDLOOP.

  ENDIF.

  IF lhc_buffer=>mt_buffer IS NOT INITIAL.
    MODIFY zfi_ilc_boe FROM TABLE @lhc_buffer=>mt_buffer.
  ENDIF.

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
