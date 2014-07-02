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

CONTROLS my_tabstrip TYPE TABSTRIP.