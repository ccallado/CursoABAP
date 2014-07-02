*----------------------------------------------------------------------*
***INCLUDE ZBC410_SOLUTION_10_I01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_sflight INPUT.
  CLEAR ws_sflight.

  SELECT SINGLE * FROM sflight INTO CORRESPONDING FIELDS OF ws_sflight
    WHERE carrid = sdyn_conn-carrid AND
          connid = sdyn_conn-connid AND
          fldate = sdyn_conn-fldate.
  IF sy-subrc <> 0.
    MESSAGE e007(bc410).
  ENDIF.

ENDMODULE.                 " CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE gv_salir.
    WHEN 'X'.
*  IF sdyn_conn-mark = 'X'.
      LEAVE TO SCREEN 0.
    WHEN 'T'.
      CALL SCREEN 150 STARTING AT 10 10 ENDING AT 42 11.
  ENDCASE.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'TIME'.
      CALL SCREEN 150 STARTING AT 10 10 ENDING AT 42 11.
    WHEN 'MODE'.
    WHEN 'SAVE'.
      UPDATE sflight FROM ws_sflight.
      IF sy-subrc NE 0.
        MESSAGE a008(bc410).
      ENDIF.

      MESSAGE s009(bc410).
      gv_ver = 'X'.
      CLEAR: gv_mantfly,
             gv_mantboo.
      my_tabstrip-activetab = 'FC1'.
    WHEN 'FC1' OR 'FC2' OR 'FC3'.
      my_tabstrip-activetab = ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

  CLEAR ok_code.
ENDMODULE.                 " USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*
*&      Module  salir_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE salir_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      CLEAR: sdyn_conn-carrid,
             sdyn_conn-connid,
             sdyn_conn-fldate.
      SET PARAMETER ID:
      'CAR' FIELD ws_sflight-carrid,
      'CON' FIELD ws_sflight-connid,
      'DAY' FIELD ws_sflight-fldate.
      CLEAR: ws_sflight,
             saplane.
      gv_ver = 'X'.
      CLEAR: gv_mantfly,
             gv_mantboo,
             sdyn_conn.
      my_tabstrip-activetab = 'FC1'.
  ENDCASE.
ENDMODULE.                 " salir_0100  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANETYPE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_planetype INPUT.
  IF sdyn_conn-planetype IS INITIAL.
    MESSAGE e555(bc410) WITH 'Plane type needed'(plt).
  ENDIF.
  SELECT SINGLE seatsmax
  FROM saplane
  INTO sdyn_conn-seatsmax
  WHERE planetype = sdyn_conn-planetype.
  IF sdyn_conn-seatsocc > sdyn_conn-seatsmax.
    MESSAGE e109(bc410).
* number of seats booked exceeds aircraft capacity
  ELSE.
    MOVE-CORRESPONDING sdyn_conn TO ws_sflight.
  ENDIF.
ENDMODULE.                 " CHECK_PLANETYPE  INPUT