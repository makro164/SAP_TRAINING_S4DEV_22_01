@AbapCatalog.sqlViewName: 'ZI00FLIGHTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Flight'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    writeActivePersistence: 'ZV00FLIGHT',

    representativeKey: ['CarrierID', 'ConnectionID', 'Flightdate'],
    semanticKey: ['CarrierID', 'ConnectionID', 'Flightdate'],

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZI_00_FlightTP
  as select from ZI_00_Flight
  association [1] to ZI_00_ConnectionTP as _Connection on  _Connection.CarrierID    = ZI_00_Flight.CarrierID
                                                       and _Connection.ConnectionID = ZI_00_Flight.ConnectionID
{
  key CarrierID,
  key ConnectionID,
  key Flightdate,
      Price,
      CurrencyCode,
      Planetype,
      MaximumSeats,
      OccupiedSeats,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Connection
}
