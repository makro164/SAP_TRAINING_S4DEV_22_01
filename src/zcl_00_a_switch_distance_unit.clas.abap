CLASS zcl_00_a_switch_distance_unit DEFINITION
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



CLASS zcl_00_a_switch_distance_unit IMPLEMENTATION.

  METHOD /bobf/if_frw_action~execute.

    "Hilfsvariablen deklarieren
    DATA connections TYPE zti00_connectiontp.
    DATA message TYPE REF TO zcm_00_connection.

    "BO-Daten lesen
    io_read->retrieve(
      EXPORTING
        iv_node       = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        eo_message    = eo_message
        et_data       = connections
        et_failed_key = et_failed_key ).

    "Nachrichten-Container erstellen
    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    "BO-Daten sequentiell durchlaufen
    LOOP AT connections REFERENCE INTO DATA(connection).
      "Fehler abfangen und behandeln
      IF connection->distanceunit <> 'KM' AND connection->distanceunit <> 'MI'.
        message = NEW zcm_00_connection(
          textid          = zcm_00_connection=>unsupported_distance_unit
          severity        = zcm_00_connection=>co_severity_error
          i_distance_unit = connection->distanceunit ).
        eo_message->add_cm( message ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = connection->key ) ).
        CONTINUE.
      ENDIF.

      "Daten ändern und zurückschreiben
      IF connection->distanceunit = 'MI'.
        connection->distanceunit = 'KM'.
        connection->distance = connection->distance * '1.609'.
      ELSEIF connection->distanceunit = 'KM'.
        connection->distanceunit = 'MI'.
        connection->distance = connection->distance / '1.609'.
      ENDIF.

      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = connection->key
          is_data = connection ).

      "Erfolgsmeldung erzeugen
      message = NEW zcm_00_connection(
        textid   = zcm_00_connection=>conversion_successful
        severity = zcm_00_connection=>co_severity_success ).
      eo_message->add_cm( message ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
