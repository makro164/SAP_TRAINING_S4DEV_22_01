@AbapCatalog.sqlViewName: 'ZI00CONNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Connection'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZV00CONNECTION',

    modelCategory: #BUSINESS_OBJECT,
    representativeKey: ['CarrierID', 'ConnectionID'],
    semanticKey: ['CarrierID', 'ConnectionID'],

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZI_00_ConnectionTP
  as select from ZI_00_Connection
  association [*] to ZI_00_FlightTP as _Flights on  _Flights.CarrierID    = ZI_00_Connection.CarrierID
                                                and _Flights.ConnectionID = ZI_00_Connection.ConnectionID
{
  key CarrierID,
  key ConnectionID,
      @ObjectModel.readOnly: true
      DepartureCountryCode,
      @ObjectModel.readOnly: true
      DepartureCity,
      @ObjectModel.mandatory: true
      DepartureAirportID,
      @ObjectModel.readOnly: true
      ArrivalCountryCode,
      @ObjectModel.readOnly: true
      ArrivalCity,
      @ObjectModel.mandatory: true
      ArrivalAirportID,
      DepartureTime,
      ArrivelTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights
}
