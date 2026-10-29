CLASS lhc_buffer DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA mt_buffer TYPE STANDARD TABLE OF zfi_outward_rd.

ENDCLASS.



CLASS lhc_ZFI_OUTWARD_RD_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations
      FOR zfi_outward_rd_cds RESULT result.

    METHODS get_global_authorizations
      FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations
      FOR zfi_outward_rd_cds RESULT result.

    METHODS create
      FOR MODIFY
      entities FOR CREATE zfi_outward_rd_cds.

    METHODS update
      FOR MODIFY
      entities FOR UPDATE zfi_outward_rd_cds.

    METHODS delete
      FOR MODIFY
      keys FOR DELETE zfi_outward_rd_cds.

    METHODS read
      FOR READ
      keys FOR READ zfi_outward_rd_cds RESULT result.

    METHODS lock
      FOR LOCK
      keys FOR LOCK zfi_outward_rd_cds.

ENDCLASS.



CLASS lhc_ZFI_OUTWARD_RD_CDS IMPLEMENTATION.


  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD create.

    DATA:
      wa_data TYPE zfi_outward_rd.

    LOOP AT entities INTO DATA(ls_entity).

      CLEAR wa_data.

      wa_data-zlcnumber = ls_entity-Zlcnumber.

      wa_data-zsl_number = ls_entity-ZslNumber.

      wa_data-zdocumentdescription = ls_entity-ZdocumentDescription.

      wa_data-created_by = cl_abap_context_info=>get_user_technical_name( ).

      wa_data-created_at = utclong_current( ).

      APPEND wa_data TO lhc_buffer=>mt_buffer.

      APPEND VALUE #(
        %cid      = ls_entity-%cid
        Zlcnumber = wa_data-zlcnumber
        ZslNumber = wa_data-zsl_number
      ) TO mapped-zfi_outward_rd_cds.

    ENDLOOP.

  ENDMETHOD.



  METHOD update.

    LOOP AT entities INTO DATA(ls_entity).

      DATA(ls_data) = VALUE zfi_outward_rd( ).

      ls_data-zlcnumber = ls_entity-Zlcnumber.

      ls_data-zsl_number = ls_entity-ZslNumber.

      IF ls_entity-%control-ZdocumentDescription = if_abap_behv=>mk-on.
        ls_data-zdocumentdescription = ls_entity-ZdocumentDescription.
      ENDIF.

      ls_data-last_changed_by = cl_abap_context_info=>get_user_technical_name( ).

      ls_data-last_changed_at = utclong_current( ).

      APPEND ls_data TO lhc_buffer=>mt_buffer.

    ENDLOOP.

  ENDMETHOD.



  METHOD delete.

    LOOP AT keys INTO DATA(ls_key).

      DELETE FROM zfi_outward_rd
        WHERE zlcnumber  = @ls_key-Zlcnumber
          AND zsl_number = @ls_key-ZslNumber.

    ENDLOOP.

  ENDMETHOD.



  METHOD read.
  ENDMETHOD.



  METHOD lock.
  ENDMETHOD.

ENDCLASS.



CLASS lsc_ZFI_OUTWARD_RD_CDS DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.



CLASS lsc_ZFI_OUTWARD_RD_CDS IMPLEMENTATION.


  METHOD finalize.
  ENDMETHOD.


  METHOD check_before_save.
  ENDMETHOD.


  METHOD save.

    LOOP AT lhc_buffer=>mt_buffer
      INTO DATA(ls_buffer).

      SELECT SINGLE *
        FROM zfi_outward_rd
        WHERE zlcnumber  = @ls_buffer-zlcnumber
          AND zsl_number = @ls_buffer-zsl_number
        INTO @DATA(ls_db).


      IF sy-subrc = 0.

        IF ls_buffer-zdocumentdescription IS NOT INITIAL.
          ls_db-zdocumentdescription = ls_buffer-zdocumentdescription.
        ENDIF.

        ls_db-last_changed_by = cl_abap_context_info=>get_user_technical_name( ).

        ls_db-last_changed_at = utclong_current( ).

        MODIFY zfi_outward_rd FROM @ls_db.

      ELSE.

        INSERT zfi_outward_rd FROM @ls_buffer.

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
