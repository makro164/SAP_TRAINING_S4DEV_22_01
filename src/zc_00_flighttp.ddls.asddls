@AbapCatalog.sqlViewName: 'ZC00FLIGHTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Flight'
@VDM.viewType: #CONSUMPTION
@Metadata.allowExtensions: true
@ObjectModel: {
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZC_00_FlightTP
  as select from ZI_00_FlightTP
  association [1] to ZC_00_ConnectionTP as _Connection on  _Connection.CarrierID    = ZI_00_FlightTP.CarrierID
                                                       and _Connection.ConnectionID = ZI_00_FlightTP.ConnectionID
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
