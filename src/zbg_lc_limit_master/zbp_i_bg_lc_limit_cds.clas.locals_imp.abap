CLASS lhc_ZI_BG_LC_LIMIT_cds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR ZI_BG_LC_LIMIT_cds RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR ZI_BG_LC_LIMIT_cds RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE ZI_BG_LC_LIMIT_cds.

    METHODS update FOR MODIFY
       entities FOR UPDATE ZI_BG_LC_LIMIT_cds.

    METHODS delete FOR MODIFY
       keys FOR DELETE ZI_BG_LC_LIMIT_cds.

    METHODS read FOR READ
       keys FOR READ ZI_BG_LC_LIMIT_cds RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK ZI_BG_LC_LIMIT_cds.

ENDCLASS.

CLASS lhc_ZI_BG_LC_LIMIT_cds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.

DATA: lt_data TYPE TABLE OF zbg_lc_li_mas_t,
        ls_data TYPE zbg_lc_li_mas_t.

  LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).

    CLEAR ls_data.

    "Key fields
    ls_data-client      = sy-mandt.
    ls_data-companycode = <fs_entity>-CompanyCode.
    ls_data-housebank   = <fs_entity>-HouseBank.
    ls_data-accountid   = <fs_entity>-AccountId.

    "Other fields
    ls_data-bankname       = <fs_entity>-BankName.
    ls_data-currency_key   = <fs_entity>-CurrencyKey.
    ls_data-bg_limit      = <fs_entity>-BgLimit.
    ls_data-lc_limit      = <fs_entity>-LcLimit.
    ls_data-effective_from = <fs_entity>-EffectiveFrom.
    ls_data-effective_to   = <fs_entity>-EffectiveTo.
    ls_data-remarks        = <fs_entity>-Remarks.

    "Administrative fields
    ls_data-createdby = sy-uname.
    GET TIME STAMP FIELD ls_data-createdon.

    MODIFY  zbg_lc_li_mas_t FROM @ls_data.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
    DATA: lt_data TYPE TABLE OF zbg_lc_li_mas_t,
        ls_data TYPE zbg_lc_li_mas_t.

    CLEAR ls_data.

    "Key fields
    ls_data-client      = sy-mandt.
    ls_data-companycode = <fs_entity>-CompanyCode.
    ls_data-housebank   = <fs_entity>-HouseBank.
    ls_data-accountid   = <fs_entity>-AccountId.

    "Other fields
    ls_data-bankname       = <fs_entity>-BankName.
    ls_data-currency_key   = <fs_entity>-CurrencyKey.
    ls_data-bg_limit      = <fs_entity>-BgLimit.
    ls_data-lc_limit      = <fs_entity>-LcLimit.
    ls_data-effective_from = <fs_entity>-EffectiveFrom.
    ls_data-effective_to   = <fs_entity>-EffectiveTo.
    ls_data-remarks        = <fs_entity>-Remarks.

    "Administrative fields
    ls_data-createdby = sy-uname.
    GET TIME STAMP FIELD ls_data-createdon.

    update  zbg_lc_li_mas_t FROM @ls_data.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
  loop at keys ASSIGNING FIELD-SYMBOL(<fs1>).
  DATA: lt_data TYPE TABLE OF zbg_lc_li_mas_t,
        ls_data TYPE zbg_lc_li_mas_t.
     ls_data-companycode = <fs1>-CompanyCode.
    ls_data-housebank   = <fs1>-HouseBank.
    ls_data-accountid   = <fs1>-AccountId.
    DELETE  zbg_lc_li_mas_t FROM @ls_data.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_BG_LC_LIMIT_CDS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_BG_LC_LIMIT_CDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
