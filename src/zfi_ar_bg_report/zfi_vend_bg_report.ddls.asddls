@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor BG Monitoring Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_VEND_BG_REPORT 
as select from zfi_vendor_bg as a

left outer join I_EnterpriseProject as b
on a.zprojectid = b.Project
{                    
    @Consumption.valueHelpDefinition: [
  {
    entity: {
      name: 'ZFI_AR_BG_VH_DOC',
      element: 'BGNumber'
    }
  }
]
    key a.zdocumentnumber          as Zdocumentnumber,
    key a.zbgclaimextensionversion as Zbgclaimextensionversion,
    key a.zbgextensionversion      as Zbgextensionversion,
    a.zprofitcenter                as Zprofitcenter,
    b.CompanyCode                  as CompanyCode,
    a.zbgtransactiontype           as Zbgtransactiontype,
    a.zbgnumber                    as Zbgnumber,
    a.zbgdate                      as Zbgdate,
    a.zbgexpirydate                as Zbgexpirydate,
    a.zprojectid                   as Zprojectid,
    a.zcreatedon                   as Zcreatedon,
    @Semantics.amount.currencyCode: 'zcurrency'
    a.zbgamount                    as Zbgamount,
    a.zcurrency                    as Zcurrency,
    a.zbgissuedate                 as Zbgissuedate,
    a.zbgtype                      as Zbgtype,
    a.zbgpurpose                   as Zbgpurpose,
    a.zclaimenddate                as Zclaimenddate,
    a.zbgextensiondate             as Zbgextensiondate,
    @Semantics.amount.currencyCode: 'zcurrency'
    a.zbillingamount               as Zbillingamount,
    a.zpurchaseorder               as Zpurchaseorder,
    a.zbankifsc                    as Zbankifsc,
    a.zbankname                    as Zbankname,
    a.zbankaddr                    as Zbankaddr,
    a.zdocumentstatus              as Zdocumentstatus,
    a.zdaysexpire                  as Zdaysexpire,
    a.zvendor                      as Zvendor,
    a.zvendorname                  as Zvendorname,
    a.zvendoraddr                  as Zvendoraddr,
    a.zbdemdconfirmbank            as Zbdemdconfirmbank,
    a.zbdemdconfirmdate            as Zbdemdconfirmdate,
    a.zpaymentreceiveddate         as Zpaymentreceiveddate,
    a.zbgdischargeddate            as Zbgdischargeddate,
    a.zbgtenure                    as Zbgtenure,
    a.zbgclaimextensiondate        as Zbgclaimextensiondate,
//    a.zbgtenure  as       zbgtenure,   
a.zbgmargin     as     Zbgmargin ,
a.zbgmarginamt as      Zbgmarginamt,
a.zcommrate  as       Zcommrate ,
//a.zcommbasis as       Zcommbasis ,
     case a.zcommbasis
      when '1.00' then 'Days'
      when '2.00' then 'Months'
      when '3.00' then 'Quarter'
      else 'Year' end as Zcommbasis,
a.zcommamount as      Zcommamount,
     a.zvendorbankifsc   as     Zvendorbankifsc     ,
     a.zvendorbankname   as     Zvendorbankname     ,
     a.zvendorbankaddr   as     Zvendorbankaddr     ,
     a.zgstcommamt       as     Zgstcommamt         ,
     a.ztotcommamt       as     Ztotcommamt         ,
     a.zremark as Zremark,
    a.flagcu                       as Flagcu,
    a.flag                         as Flag,
    a.createdon                    as Createdon,
    a.createdat                    as Createdat,
    a.createdby                    as Createdby,
    a.changedon                    as Changedon,
    a.changedat                    as Changedat,
    a.changedby                    as Changedby,
    a.lastchanged                  as Lastchanged
}
