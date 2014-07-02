*----------------------------------------------------------------------*
***INCLUDE ZBC410_SOLUTION_10_O01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  RELLENA_SDYN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE rellena_sdyn OUTPUT.
  CLEAR ok_code.
  MOVE-CORRESPONDING ws_sflight TO sdyn_conn.
  gv_hora = sy-uzeit.
  IF gv_salir IS INITIAL.
    SET CURSOR FIELD 'SDYN_CONN-FLDATE'.
  ENDIF.
ENDMODULE.                 " RELLENA_SDYN  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF gv_mantfly = 'X'.
    SET PF-STATUS 'STATUS-100'.
  ELSE.
    SET PF-STATUS 'STATUS-100' EXCLUDING 'SAVE'.
  ENDIF.

  CASE 'X'.
    WHEN gv_ver.
      SET TITLEBAR  'TITULO-100'
        WITH 'VER' ws_sflight-carrid ws_sflight-connid.
      dynnr = '110'.

    WHEN gv_mantfly.
      SET TITLEBAR  'TITULO-100'
        WITH 'Mantener vuelo' ws_sflight-carrid ws_sflight-connid.
      dynnr = '120'.
    WHEN gv_mantboo.
      SET TITLEBAR  'TITULO-100'
        WITH 'Mantener reservas' ws_sflight-carrid ws_sflight-connid.
      dynnr = '130'.
  ENDCASE.

*  my_tabstrip-activetab = 'P1'.
ENDMODULE.                 " STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  STATUS_0150  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0150 OUTPUT.
  SET PF-STATUS 'STATUS-150'.
  SET TITLEBAR  'TITULO-150' WITH ws_sflight-fldate.
ENDMODULE.                 " STATUS_0150  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  modifica_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modifica_0100 OUTPUT.
  LOOP AT SCREEN.
*    IF screen-group1 = 'FLY' AND
*       gv_mantfly = ' '.
*      screen-input = 1.
*      MODIFY SCREEN.
*    ENDIF.
*
*    IF screen-group1 = 'BOK' AND
*       gv_mantboo = ' '.
*      screen-input = 1.
*      MODIFY SCREEN.
*    ENDIF.
*
*    IF screen-group2 = 'MOD' AND
*       gv_ver = 'X'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*
    IF gv_mantfly = 'X' AND screen-name = 'SDYN_CONN-PLANETYPE'.
      screen-input = 1.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

ENDMODULE.                 " modifica_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  GET_SPFLI  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_spfli OUTPUT.
  ON CHANGE OF ws_sflight-carrid
            OR ws_sflight-connid.
*    CLEAR spfli.
    SELECT SINGLE * INTO CORRESPONDING FIELDS OF
    sdyn_conn FROM spfli
    WHERE carrid = ws_sflight-carrid
      AND connid = ws_sflight-connid.
  ENDON.
ENDMODULE.                 " GET_SPFLI  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  GET_SPLANE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_splane OUTPUT.
  CLEAR saplane.
  SELECT SINGLE *
  FROM saplane
  INTO saplane
  WHERE planetype = sdyn_conn-planetype.

ENDMODULE.                 " GET_SPLANE  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  FILL_DYNNR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE fill_dynnr OUTPUT.
  CASE my_tabstrip-activetab.
    WHEN 'FC1'.
      dynnr = 110.
      SET TITLEBAR  'TITULO-100'
        WITH 'VER' ws_sflight-carrid ws_sflight-connid.
    WHEN 'FC2'.
      dynnr = 120.
      SET TITLEBAR  'TITULO-100'
        WITH 'Mantener vuelo' ws_sflight-carrid ws_sflight-connid.
    WHEN 'FC3'.
      SET TITLEBAR  'TITULO-100'
        WITH 'Mantener reservas' ws_sflight-carrid ws_sflight-connid.
      dynnr = 130.
    WHEN OTHERS.
      SET TITLEBAR  'TITULO-100'
        WITH 'VER' ws_sflight-carrid ws_sflight-connid.
      my_tabstrip-activetab = 'FC1'.
      dynnr = 110.
  ENDCASE.
ENDMODULE.                 " FILL_DYNNR  OUTPUT