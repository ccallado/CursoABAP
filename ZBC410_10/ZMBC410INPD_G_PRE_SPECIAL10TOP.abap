*&---------------------------------------------------------------------*
*& Include MBC410DIAD_MODIFY_SCREENTOP                                 *
*&                                                                     *
*&---------------------------------------------------------------------*

PROGRAM  sapmbc410diad_modify_screen   .

DATA wa_spfli TYPE spfli.
TABLES sdyn_conn.


DATA: ok_code LIKE sy-ucomm,
      gv_llegada TYPE c,
      gv_salida  TYPE c,
      gv_editar  TYPE c,
      gv_ver     TYPE c VALUE 'X'.