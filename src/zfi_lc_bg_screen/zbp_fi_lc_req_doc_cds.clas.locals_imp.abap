CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.
    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_lc_req_doc.

    CLASS-DATA mt_delete TYPE STANDARD TABLE OF zfi_lc_req_doc.
ENDCLASS.

CLASS lhc_ZFI_LC_REQ_DOC_CDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zfi_lc_req_doc_cds RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zfi_lc_req_doc_cds RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE zfi_lc_req_doc_cds.

    METHODS update FOR MODIFY
       entities FOR UPDATE zfi_lc_req_doc_cds.

    METHODS delete FOR MODIFY
       keys FOR DELETE zfi_lc_req_doc_cds.

    METHODS read FOR READ
       keys FOR READ zfi_lc_req_doc_cds RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK zfi_lc_req_doc_cds.

ENDCLASS.

CLASS lhc_ZFI_LC_REQ_DOC_CDS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

  DATA:
    wa_data TYPE zfi_lc_req_doc.

  LOOP AT entities INTO DATA(ls_entity).

    CLEAR wa_data.

    wa_data-company_code = ls_entity-CompanyCode.
    wa_data-lc_number    = ls_entity-LcNumber.
    wa_data-sl_number    = ls_entity-SlNumber.

    wa_data-document_description =
      ls_entity-DocumentDescription.

    wa_data-createdon =
      cl_abap_context_info=>get_system_date( ).

    wa_data-createdat =
      cl_abap_context_info=>get_system_time( ).

    wa_data-createdby =
      cl_abap_context_info=>get_user_technical_name( ).

    APPEND wa_data TO lhc_buffer=>mt_buffer.

    APPEND VALUE #(
      %cid        = ls_entity-%cid
      CompanyCode = wa_data-company_code
      LcNumber    = wa_data-lc_number
      SlNumber    = wa_data-sl_number
    ) TO mapped-zfi_lc_req_doc_cds.

  ENDLOOP.

  ENDMETHOD.

*METHOD update.
*
*  LOOP AT entities INTO DATA(ls_entity).
*
*    "------------------------------------------------------------
*    " Get existing record using ORIGINAL KEY
*    "------------------------------------------------------------
*    SELECT SINGLE *
*      FROM zfi_lc_req_doc
*      WHERE company_code = @ls_entity-CompanyCode
*        AND lc_number    = @ls_entity-LcNumber
*        AND sl_number    = @ls_entity-SlNumber
*      INTO @DATA(ls_data).
*
*    IF sy-subrc <> 0.
*
*      APPEND VALUE #(
*        %tky = ls_entity-%tky
*        %msg = new_message_with_text(
*                 severity = if_abap_behv_message=>severity-error
*                 text     = 'LC Required Document record not found.'
*               )
*      ) TO reported-zfi_lc_req_doc_cds.
*
*      CONTINUE.
*
*    ENDIF.
*
*
*    "------------------------------------------------------------
*    " ONLY Document Description is editable
*    "------------------------------------------------------------
*    IF ls_entity-%control-DocumentDescription =
*       if_abap_behv=>mk-on.
*
*      ls_data-document_description =
*        ls_entity-DocumentDescription.
*
*    ENDIF.
*
*
*    "------------------------------------------------------------
*    " IMPORTANT:
*    " Never change these keys during Document Description update
*    "------------------------------------------------------------
*    ls_data-company_code = ls_entity-CompanyCode.
*    ls_data-lc_number    = ls_entity-LcNumber.
*    ls_data-sl_number    = ls_entity-SlNumber.
*
*
*    "------------------------------------------------------------
*    " Add to update buffer
*    "------------------------------------------------------------
*    APPEND ls_data TO lhc_buffer=>mt_buffer.
*
*  ENDLOOP.
*
*ENDMETHOD.

METHOD update.

  LOOP AT entities INTO DATA(ls_entity).

    "------------------------------------------------------------
    " Get existing Required Document record
    "------------------------------------------------------------
    SELECT SINGLE *
      FROM zfi_lc_req_doc
      WHERE company_code = @ls_entity-CompanyCode
        AND lc_number    = @ls_entity-LcNumber
        AND sl_number    = @ls_entity-SlNumber
      INTO @DATA(ls_data).

    IF sy-subrc <> 0.

      APPEND VALUE #(
        %tky = ls_entity-%tky
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'LC Required Document record not found.'
               )
      ) TO reported-zfi_lc_req_doc_cds.

      CONTINUE.

    ENDIF.


    "------------------------------------------------------------
    " IMPORTANT
    " LC Number remains the same as the LC being updated
    "------------------------------------------------------------
    ls_data-company_code = ls_entity-CompanyCode.
    ls_data-lc_number    = ls_entity-LcNumber.
    ls_data-sl_number    = ls_entity-SlNumber.


    "------------------------------------------------------------
    " Update Document Description if changed
    "------------------------------------------------------------
    IF ls_entity-%control-DocumentDescription =
       if_abap_behv=>mk-on.

      ls_data-document_description =
        ls_entity-DocumentDescription.

    ENDIF.


    "------------------------------------------------------------
    " Add record to buffer
    "------------------------------------------------------------
    APPEND ls_data TO lhc_buffer=>mt_buffer.

  ENDLOOP.

ENDMETHOD.


  METHOD delete.
  LOOP AT keys INTO DATA(ls_key).

    APPEND VALUE #(
      company_code = ls_key-CompanyCode
      lc_number    = ls_key-LcNumber
      sl_number    = ls_key-SlNumber
    ) TO lhc_buffer=>mt_delete.

  ENDLOOP.
  ENDMETHOD.

*  METHOD read.
*  ENDMETHOD.
METHOD read.

  LOOP AT keys INTO DATA(ls_key).

    SELECT SINGLE
      FROM zfi_lc_req_doc
      FIELDS
        company_code,
        lc_number,
        sl_number,
        document_description,
        createdon,
        createdat,
        createdby
      WHERE company_code = @ls_key-CompanyCode
        AND lc_number    = @ls_key-LcNumber
        AND sl_number    = @ls_key-SlNumber
      INTO @DATA(ls_data).

    IF sy-subrc = 0.

      APPEND VALUE #(
        %tky                  = ls_key-%tky
        CompanyCode           = ls_data-company_code
        LcNumber              = ls_data-lc_number
        SlNumber              = ls_data-sl_number
        DocumentDescription   = ls_data-document_description
        CreatedOn             = ls_data-createdon
        CreatedAt             = ls_data-createdat
        CreatedBy             = ls_data-createdby
      ) TO result.

    ENDIF.

  ENDLOOP.

ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZFI_LC_REQ_DOC_CDS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZFI_LC_REQ_DOC_CDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

  "------------------------------------------------------------
  " 1. DELETE
  "------------------------------------------------------------
  IF lhc_buffer=>mt_delete IS NOT INITIAL.

    LOOP AT lhc_buffer=>mt_delete INTO DATA(ls_delete).

      DELETE FROM zfi_lc_req_doc
        WHERE company_code = @ls_delete-company_code
          AND lc_number    = @ls_delete-lc_number
          AND sl_number    = @ls_delete-sl_number.

    ENDLOOP.

  ENDIF.


  "------------------------------------------------------------
  " 2. CREATE / UPDATE
  "------------------------------------------------------------
  IF lhc_buffer=>mt_buffer IS NOT INITIAL.

    LOOP AT lhc_buffer=>mt_buffer INTO DATA(ls_buffer).

      MODIFY zfi_lc_req_doc FROM @ls_buffer.

    ENDLOOP.

  ENDIF.


  "------------------------------------------------------------
  " 3. CLEAR
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
