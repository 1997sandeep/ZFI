@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AR BG Monitoring Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZFI_AR_BG_REPORT
  as select from    zfi_customer_bg     as a

    left outer join I_EnterpriseProject as b on a.zjobnumber = b.Project
{
      @Consumption.valueHelpDefinition: [
      {
      entity: {
        name: 'ZFI_AR_BG_VH_DOC',
        element: 'BGNumber'
      }
      }
      ]
  key a.zslno                    as Zslno,
  key a.zbgclaimextensionversion as Zbgclaimextensionversion,
  key a.zbgextensionversion      as Zbgextensionversion,
      a.zprofitcenter            as Zprofitcenter,
      a.zcontractno                         as zSales_Contractno,
      a.zcustomername  as Zcustomeraddress,
      b.CompanyCode              as CompanyCode,
      a.zconcernperson           as Zconcernperson,
      a.zjobnumber               as Zjobnumber,
      a.zbeneficiarycode         as Zbeneficiarycode,
      a.zbeneficiaryname         as Zbeneficiaryname,
      a.zbgnumber                as Zbgnumber,
      a.zbgpurpose               as Zbgpurpose,
      a.zbgtype                  as Zbgtype,
      a.zbgamount                as Zbgamount,
      a.zbgissuancedate          as Zbgissuancedate,
      a.zbgexpirydate            as Zbgexpirydate,
      a.zbgclaimdate             as Zbgclaimdate,
      a.zbgextupto               as Zbgextupto,
      a.bgclaimperiod            as Bgclaimperiod,
      a.zbgdaysextended          as Zbgdaysextended,
      a.zbgoverdue               as Zbgoverdue,
      a.zbgtennure               as Zbgtennure,
      a.zbgmargin                as Zbgmargin,
      a.zbgmarginamt             as Zbgmarginamt,
      a.zbgissuanceamt           as Zbgissuanceamt,
      a.zbgsfmsbgamt             as Zbgsfmsbgamt,
      a.zbgstampamt              as Zbgstampamt,
      a.zbggstamt                as Zbggstamt,
      a.zbgtotalchg              as Zbgtotalchg,
      a.zbgstatus                as Zbgstatus,
      a.zbgremarks               as Zbgremarks,
      a.flagcu                   as Flagcu,
      a.flag                     as Flag,
      a.zbgtenuredays            as ZbgTenuredays,
      a.zbgtenuremonths          as zbgTenureMonths,
      a.zcommamount as Zcommamount,
//      a.zcommbasis as Zcommbasis,
      case a.zcommbasis
      when '1' then 'Days'
      when '2.00' then 'Months'
      when '3' then 'Quarter'
      else 'Year' end as Zcommbasis,
      
      a.zcommrate as Zcommrate,
      a.znitdate as Znitdate,
      a.znitno as Znitno,
      a.zbankifsc           as   Zbankifsc         ,
      a.zbankname           as   Zbankname         ,
      a.zbankaddr           as   Zbankaddr         ,
      a.zcustomerbankifsc   as   Zcustomerbankifsc ,
      a.zcustomerbankname   as   Zcustomerbankname ,
      a.zcustomerbankaddr   as   Zcustomerbankaddr ,
      a.zgstcommamt         as   Zgstcommamt       ,
      a.zendorsement        as   Zendorsement      ,
      a.zonerous            as   Zonerous          ,
      a.ztenderbenefic      as   ztenderbenefic    ,
      a.createdon                as Createdon,
      a.createdat                as Createdat,
      a.createdby                as Createdby,
      a.changedon                as Changedon,
      a.changedat                as Changedat,
      a.changedby                as Changedby,
      a.lastchanged              as Lastchanged
}
