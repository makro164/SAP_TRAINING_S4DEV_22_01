@AbapCatalog.sqlViewName: 'ZI00FLIGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View: Flight'
@VDM.viewType: #BASIC
define view ZI_00_Flight
  as select from sflight
{
  key carrid    as CarrierID,
  key connid    as ConnectionID,
  key fldate    as Flightdate,
      price     as Price,
      currency  as CurrencyCode,
      planetype as Planetype,
      seatsmax  as MaximumSeats,
      seatsocc  as OccupiedSeats
}
