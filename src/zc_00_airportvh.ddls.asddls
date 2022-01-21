@AbapCatalog.sqlViewName: 'ZC00AIRPORTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Airport'
@VDM.viewType: #CONSUMPTION
define view ZC_00_AirportVH
  as select from sairport
{
  key id   as Id,
      name as Name
}
