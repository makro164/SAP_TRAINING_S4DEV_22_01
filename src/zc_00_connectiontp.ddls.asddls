@AbapCatalog.sqlViewName: 'ZC00CONNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Connection'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel: {
    transactionalProcessingDelegated: true,

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZC_00_ConnectionTP
  as select from ZI_00_ConnectionTP
  association [*] to ZC_00_FlightTP  as _Flights          on  _Flights.CarrierID    = ZI_00_ConnectionTP.CarrierID
                                                          and _Flights.ConnectionID = ZI_00_ConnectionTP.ConnectionID
  association [1] to ZC_00_AirportVH as _DepartureAirport on  _DepartureAirport.Id = ZI_00_ConnectionTP.DepartureAirportID
  association [1] to ZC_00_AirportVH as _ArrivalAirport   on  _ArrivalAirport.Id = ZI_00_ConnectionTP.ArrivalAirportID
{
  key CarrierID,
  key ConnectionID,
      DepartureCountryCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      DepartureCity,
      @Consumption.valueHelp: '_DepartureAirport'
      DepartureAirportID,
      ArrivalCountryCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      ArrivalCity,
      @Consumption.valueHelp: '_ArrivalAirport'
      ArrivalAirportID,
      DepartureTime,
      ArrivelTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights,
      _DepartureAirport,
      _ArrivalAirport
}
