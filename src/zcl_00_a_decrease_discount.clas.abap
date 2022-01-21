CLASS zcl_00_a_decrease_discount DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_a_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_action~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00_a_decrease_discount IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    "Hilfsvariablen deklarieren
    DATA customers TYPE zti00_customertp.
    DATA message TYPE REF TO zcm_00_customer.

    "BO-Daten lesen
    io_read->retrieve(
      EXPORTING
        iv_node       = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        eo_message    = eo_message
        et_data       = customers
        et_failed_key = et_failed_key ).

    "Nachrichten-Container erstellen
    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    "BO-Daten sequentiell durchlaufen
    LOOP AT customers REFERENCE INTO DATA(customer).
      "Fehler abfangen und behandeln
      IF customer->discount - 5 < 0.
        message = NEW zcm_00_customer(
          textid   = zcm_00_customer=>decrease_failed
          severity = zcm_00_customer=>co_severity_error ).
        eo_message->add_cm( message ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = customer->key ) ).
        CONTINUE.
      ENDIF.

      "Daten ändern und zurückschreiben
      customer->discount = customer->discount - 5.

      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = customer->key
          is_data = customer ).

      "Erfolgsmeldung erzeugen
      message = NEW zcm_00_customer(
        textid   = zcm_00_customer=>decrease_successful
        severity = zcm_00_customer=>co_severity_success ).
      eo_message->add_cm( message ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
