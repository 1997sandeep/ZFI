@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BG Number F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZFI_VEND_BG_BGNO_F4 
//as select from zfi_vendor_bg
//{                    
//    key zdocumentnumber as BGNumber,
//    
//        zbgnumber       as BGBankNumber
//                        
////        cast( 'Vendor' as abap.char(10) ) as TransactionType
//}
//                             
//union all
//                       
//select from zfi_customer_bg
//{                         
//    key zslno     as BGNumber,
//    
//        zbgnumber as BGBankNumber
//                                 
////        cast( 'Customer' as abap.char(10) ) as TransactionType
//}

as select from zfi_vendor_bg as V

    inner join ZFI_VEND_BG_MAX_VER as MV
      on  MV.BGNumber            = V.zdocumentnumber
      and MV.MaxExtensionVersion = V.zbgextensionversion

    inner join ZFI_VEND_BG_MAX_CLAIM as MC
      on  MC.BGNumber             = V.zdocumentnumber
      and MC.MaxClaimExtensionVersion = V.zbgclaimextensionversion

{
    key V.zdocumentnumber          as BGNumber,
        V.zbgnumber                as BGBankNumber,
        V.zbgclaimextensionversion as BGClaimExtensionVersion,
        V.zbgextensionversion      as BGExtensionVersion
}

union all

select from zfi_customer_bg as C

    inner join ZFI_CUST_BG_MAX_VER as MV
      on  MV.BGNumber            = C.zslno
      and MV.MaxExtensionVersion = C.zbgextensionversion

    inner join ZFI_CUST_BG_MAX_CLAIM as MC
      on  MC.BGNumber                 = C.zslno
      and MC.MaxClaimExtensionVersion = C.zbgclaimextensionversion

{
    key C.zslno                    as BGNumber,
        C.zbgnumber                as BGBankNumber,
        C.zbgclaimextensionversion as BGClaimExtensionVersion,
        C.zbgextensionversion      as BGExtensionVersion
}


 
