@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BG And LC Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBG_LC_REPORT as select from zbg_lc_li_mas_t as a
left outer join ZBG_LC_AMOUNT as b on b.HouseBank = a.housebank
left outer join ZLC_SCREEN_DATA as c on c.HouseBank = a.housebank and a.accountid = c.accid
{
   @UI.lineItem: [{ label: 'Company Code',position: 10  }]
   @UI.identification: [{ label: 'Company Code' }]
   @UI.selectionField: [{ position: 10 }]
   @Consumption.valueHelpDefinition: [{ entity : { name: 'ZCOMPANYCODEE_F4' ,element: 'CompanyCode'  } }]
   key a.companycode as Companycode,
     @UI.lineItem: [{ label: 'House Bank',position: 20  }]
   @UI.identification: [{ label: 'House Bank' }]
   @UI.selectionField: [{ position: 20 }]
   @Consumption.valueHelpDefinition: [{ entity : { name: 'ZHOUSEBANKK_F4' ,element: 'HouseBank'  } }]
   key a.housebank as Housebank,
     @UI.lineItem: [{ label: 'Account Id',position: 30  }]
   @UI.identification: [{ label: 'Account Id' }]
   @UI.selectionField: [{ position: 30 }]
   @Consumption.valueHelpDefinition: [{ entity : { name: 'ZACCONTID_F4' , element: 'HouseBankAccount' } } ] 
   key a.accountid as Accountid,
     @UI.lineItem: [{ label: 'Bank Name',position: 40  }]
   @UI.identification: [{ label: 'Bank Name' }]
   a.bankname as Bankname,
      @UI.lineItem: [{ label: 'Currency',position: 50  }]
   @UI.identification: [{ label: 'Currency' }]
   a.currency_key as CurrencyKey,
      @UI.lineItem: [{ label: 'BG Limit By Bank',position: 60  }]
   @UI.identification: [{ label: 'BG Limit By Bank' }]
   a.bg_limit as BgLimit,
     @UI.lineItem: [{ label: 'BG Limit Utilized',position: 62  }]
   @UI.identification: [{ label: 'BG Limit Utilized' }]
   b.bg_amount as bgliulti,
   
    @UI.lineItem: [{ label: 'Available BG Limit',position: 65  }]
   @UI.identification: [{ label: 'Available BG Limit ' }] 
   coalesce(a.bg_limit,0) - coalesce(b.bg_amount,0) as avai_bg,
   
      @UI.lineItem: [{ label: 'Lc Limit By Bank ',position: 70  }]
   a.lc_limit as LcLimit,
   c.LcCurrency,
      @Semantics.amount.currencyCode: 'LcCurrency'
      @UI.lineItem: [{ label: 'LC Limit Utilized',position: 75  }]
   c.LcAmount as LcAmount,
   
      @UI.lineItem: [{ label: 'Lc Limit',position: 80  }]
   @UI.identification: [{ label: 'Available LC Limit' }]
  coalesce(a.lc_limit,0) - coalesce(cast( c.LcAmount as abap.dec( 12, 2) ),0) as avai_lc,
   
   
   
//      @UI.lineItem: [{ label: 'Effective From',position: 80  }]
//   @UI.identification: [{ label: 'Effective From' }]
//   a.effective_from as EffectiveFrom,
//   
//      @UI.lineItem: [{ label: 'Effective To',position: 90  }]
//   @UI.identification: [{ label: 'Effective To' }]
//   a.effective_to as EffectiveTo,
   
      @UI.lineItem: [{ label: 'Remark',position: 100  }]
   @UI.identification: [{ label: 'Remark' }]
   a.remarks as Remarks
//   createdby as Createdby,
//   createdon as Createdon,
//   changedby as Changedby,
//   changedon as Changedon 
}
