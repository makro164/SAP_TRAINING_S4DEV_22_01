@AbapCatalog.sqlViewName: 'ZI00BOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View: Booking'
@VDM.viewType: #BASIC
define view ZI_00_Booking
  as select from sbook
{
  key carrid     as CarrierID,
  key connid     as ConnectionID,
  key fldate     as Flightdate,
  key bookid     as BookingID,
      customid   as CustomerID,
      class      as FlightClass,
      order_date as OrderDate
}
