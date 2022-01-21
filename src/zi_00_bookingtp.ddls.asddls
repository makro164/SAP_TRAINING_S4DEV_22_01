@AbapCatalog.sqlViewName: 'ZI00BOOKTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Booking'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    writeActivePersistence: 'ZV00BOOKING',

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZI_00_BookingTP
  as select from ZI_00_Booking
  association [1] to ZI_00_CustomerTP as _Customer on _Customer.ID = ZI_00_Booking.CustomerID
{
  key CarrierID,
  key ConnectionID,
  key Flightdate,
  key BookingID,
      CustomerID,
      FlightClass,
      OrderDate,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Customer
}
