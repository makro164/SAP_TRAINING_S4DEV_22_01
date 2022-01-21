@AbapCatalog.sqlViewName: 'ZI00CUSTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Customer'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel: {
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'SCUSTOM',

    modelCategory: #BUSINESS_OBJECT,
    representativeKey: 'ID',
    semanticKey: ['Name'],

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZI_00_CustomerTP
  as select from ZI_00_Customer
  association [*] to ZI_00_BookingTP as _Bookings on _Bookings.CustomerID = ZI_00_Customer.ID
{
  key ID,
      Name,
      Street,
      Postcode,
      City,
      Country,
      Discount,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Bookings
}
