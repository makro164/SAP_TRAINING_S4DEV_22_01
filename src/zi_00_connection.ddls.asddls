@AbapCatalog.sqlViewName: 'ZI00CONN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View: Connection'
@VDM.viewType: #BASIC
define view ZI_00_Connection
  as select from spfli
{
  key carrid    as CarrierID,
  key connid    as ConnectionID,
      countryfr as DepartureCountryCode,
      cityfrom  as DepartureCity,
      airpfrom  as DepartureAirportID,
      countryto as ArrivalCountryCode,
      cityto    as ArrivalCity,
      airpto    as ArrivalAirportID,
      deptime   as DepartureTime,
      arrtime   as ArrivelTime,
      distance  as Distance,
      distid    as DistanceUnit,
      fltype    as FlightType,
      period    as Period
}
