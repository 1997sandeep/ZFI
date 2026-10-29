@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor Bank Guarantee Monitoring'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_VENDOR_BG_CDS
  as select from zfi_vendor_bg
{
      @Consumption.valueHelpDefinition: [
      {
      entity: {
        name: 'ZFI_VEND_BG_BGNO_F4',
        element: 'BGNumber'
      },
      additionalBinding: [
        {
          localElement: 'Zbgtransactiontype',
          element: 'TransactionType',
          usage: #FILTER
        }
      ]
      }
      ]
  key zdocumentnumber          as Zdocumentnumber,
  key zbgextensionversion      as Zbgextensionversion,
  key zbgclaimextensionversion as Zbgclaimextensionversion,
      zprofitcenter            as Zprofitcenter,
      zbgtransactiontype       as Zbgtransactiontype,
      zbgnumber                as Zbgnumber,
      zbgdate                  as Zbgdate,
      zbgexpirydate            as Zbgexpirydate,
      zprojectid               as Zprojectid,
      zcreatedon               as Zcreatedon,
      @Semantics.amount.currencyCode: 'zcurrency'
      zbgamount                as Zbgamount,
      zcurrency                as Zcurrency,
      zbgissuedate             as Zbgissuedate,
      zbgtype                  as Zbgtype,
      zbgpurpose               as Zbgpurpose,
      zclaimenddate            as Zclaimenddate,
      zbgextensiondate         as Zbgextensiondate,
      @Semantics.amount.currencyCode: 'zcurrency'
      zbillingamount           as Zbillingamount,
      zpurchaseorder           as Zpurchaseorder,
      zbankifsc                as Zbankifsc,
      zbankname                as Zbankname,
      zbankaddr                as Zbankaddr,
      zdocumentstatus          as Zdocumentstatus,
      zdaysexpire              as Zdaysexpire,
      zvendor                  as Zvendor,
      zvendorname              as Zvendorname,
      zvendoraddr              as Zvendoraddr,
      zbdemdconfirmbank        as Zbdemdconfirmbank,
      zbdemdconfirmdate        as Zbdemdconfirmdate,
      zpaymentreceiveddate     as Zpaymentreceiveddate,
      zbgdischargeddate        as Zbgdischargeddate,
      zbgtenure                as Zbgtenure,
      zbgclaimextensiondate    as Zbgclaimextensiondate,
      flagcu                   as Flagcu,
      flag                     as Flag,
      zcommrate                as Zcommrate,
      zcommbasis               as Zcommbasis,
      zcommamount              as Zcommamount,
      zbgmargin                as Zbgmargin,
      zbgmarginamt             as Zbgmarginamt,
      zremark                  as Zremark,
      zbgtenuredays            as Zbgtenuredays,
      zbgtenuremonths          as Zbgtenuremonths,
      zvendorbankifsc        as Zvendorbankifsc,
      zvendorbankname        as Zvendorbankname,
      zvendorbankaddr        as Zvendorbankaddr,
      zgstcommamt              as Zgstcommamt,
      ztotcommamt              as Ztotcommamt,
      zotherrate          as Zotherrate,
      zotheramount        as Zotheramount,
      bg_currency as BGcurrency,
           zdms                          as DMS,
          zfile                         as FileNo,
          zmimetype                     as MimeType,
          zfilename                     as FileName,
      createdon                as Createdon,
      createdat                as Createdat,
      createdby                as Createdby,
      changedon                as Changedon,
      changedat                as Changedat,
      changedby                as Changedby,
      lastchanged              as Lastchanged
}
