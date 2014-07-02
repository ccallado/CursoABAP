*&---------------------------------------------------------------------*
*& Include ZBC410_SOLUTION_10_TOP                            Module Pool      ZBC410_SOLUTION_09
*&
*&---------------------------------------------------------------------*

PROGRAM  zbc410_solution_10.

TABLES: sdyn_conn,
        saplane.

DATA: ws_sflight TYPE sflight,
      gv_salir   TYPE c,
      gv_hora    TYPE syst-uzeit,
      ok_code    TYPE sy-ucomm,
      dynnr      TYPE sy-dynnr.

DATA: gv_ver     TYPE c VALUE 'X',
      gv_mantfly TYPE c,
      gv_mantboo TYPE c.

*CONTROLS my_tabstrip TYPE TABSTRIP.

*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'MY_TABSTRIP'
CONSTANTS: BEGIN OF C_MY_TABSTRIP,
             TAB1 LIKE SY-UCOMM VALUE 'FC1',
             TAB2 LIKE SY-UCOMM VALUE 'FC2',
             TAB3 LIKE SY-UCOMM VALUE 'FC3',
           END OF C_MY_TABSTRIP.
*&SPWIZARD: DATA FOR TABSTRIP 'MY_TABSTRIP'
CONTROLS:  MY_TABSTRIP TYPE TABSTRIP.
DATA:      BEGIN OF G_MY_TABSTRIP,
             SUBSCREEN   LIKE SY-DYNNR,
             PROG        LIKE SY-REPID VALUE 'ZBC410_SOLUTION_10_B',
             PRESSED_TAB LIKE SY-UCOMM VALUE C_MY_TABSTRIP-TAB1,
           END OF G_MY_TABSTRIP.