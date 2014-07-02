*----------------------------------------------------------------------*
*   INCLUDE MBC410DIAD_MODIFY_SCREENO01                                *
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  TRANS_TO_200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE trans_to_200 OUTPUT.

  MOVE-CORRESPONDING wa_spfli TO sdyn_conn.

ENDMODULE.                             " GET_SPFLI_DATA  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  SET PF-STATUS 'DYNPRO'.
*  SET TITLEBAR 'xxx'.

ENDMODULE.                             " STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'DYNPRO'.
*  SET TITLEBAR 'xxx'.

ENDMODULE.                             " STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  clear_ok_code  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.                             " clear_ok_code  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  modify_screen_200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen_200 OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 = 'ARR' AND
       gv_llegada = ' '.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.

    IF screen-group1 = 'DEP' AND
       gv_salida = ' '.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.

    IF screen-group2 = 'MOD' AND
       gv_editar = 'X'.
      screen-input = 1.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.
ENDMODULE.                 " modify_screen_200  OUTPUT