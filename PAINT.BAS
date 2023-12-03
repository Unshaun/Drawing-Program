DECLARE SUB wkey ()
DECLARE SUB finp (xx!, yy!, cc!) : DECLARE SUB killmouse ()
DECLARE SUB organizer () : DECLARE SUB delete ()
DECLARE SUB load (fun) :      DECLARE SUB loader ()
DECLARE SUB save () :      DECLARE SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
DECLARE SUB MouseHide () : DECLARE SUB MouseDriver (ax%, bx%, cx%, dx%)
DECLARE SUB MouseShow () : DECLARE FUNCTION mouseInit% ()
COMMON SHARED x%, y%, lb%, rb%, rght$, lft$, up$, dwn$, name$, picture2(), picturem2()
COMMON SHARED list$, getpict(), msfct, editmsk, oeditmsk, linkpic, olinkpic, aa$, a$, loaded


' L - Load            SHIFT + 1 - Line
' S - Save                  " 2 - Box
' D - Delete                " 3 - Circle
' O - Organizer             " 4 - Get/Put
' M - Toggle Mask Edit      " 5 - Paint
' P - Toggle Picture Link   " 6 - Draw
' C - Clear                 " 7 - Color Swap
' \ - Quit                  " 9 - Rotate 90
'  - Translate Right       " 0 - Mirror
'  - Translate Left        " < - Small Pic to Big
'  - Translate Up          " > - Big Pic to Small
'  - Translate Down        " ? - 3 Way Split
'

CHDIR "c:\qbasic\grafix"
SCREEN 7:  RANDOMIZE TIMER
REDIM SHARED getpict(100)
GET (1, 1)-STEP(1, 1), getpict
LET rght$ = CHR$(0) + CHR$(77)
LET dwn$ = CHR$(0) + CHR$(80)
LET lft$ = CHR$(0) + CHR$(75)
LET up$ = CHR$(0) + CHR$(72)
msfct = 1
editmsk = 15
oeditmsk = 4
linkpic = 14
olinkpic = 4


OUT &H3C8, 21: OUT &H3C9, 63: OUT &H3C9, 36: OUT &H3C9, 22 ' s k i n  COLOR 13


DIM SHARED mouse$  '-----------------------------------------
mouse$ = SPACE$(57)                                      '  |
FOR I% = 1 TO 57                                         '  |
  READ a$                                                '  |
  h$ = CHR$(VAL("&H" + a$))                              '  |
  MID$(mouse$, I%, 1) = h$                               '  |
NEXT I%                                                  '  |
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B     'this stuff is
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53     'complicated you
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F     'shouldn't worry
DATA 8B,5E,06,89,17,5D,CA,08,00                          'about in now
cc1% = 15
cc2% = 0
							 '  |
							 '  |
'------------------------------------------------------------
CLS
ms% = mouseInit%                      '<--calls function to check and
IF NOT ms% THEN                       'see if mouse is installed
  PRINT "Mouse not found"             '<--if none then end
  SLEEP: nomouse = 5                  '(you can take out END so it won't
END IF                                'quit)
ON ERROR GOTO errorplace:
IF 5 = 6 THEN
errorplace:
SCREEN 7, , 3, 3: CLS
LOCATE 10, 5: COLOR 4: PRINT "   YOU FUCKED SOMETHING UP": SLEEP 3
SCREEN 7, , 0, 0
GOSUB resetlr:
RESUME aftererror:
END IF
SCREEN 7, , 1, 0
LINE (0, 0)-STEP(250, 199), 0, BF: LINE (0, 0)-STEP(250, 199), 7, B: LINE (251, 0)-STEP(0, 199), 8
FOR B% = 0 TO 49: LINE (B% * 5, 0)-STEP(0, 198), 7: NEXT B%: FOR B% = 0 TO 49: LINE (0, B% * 4)-STEP(250, 0), 7: NEXT B%: FOR m = 0 TO 7: LOCATE 3, 33 + m: COLOR m: PRINT "Û": NEXT m: FOR m = 8 TO 15: LOCATE 2, 32 + (m - 7): COLOR m: PRINT "Û": NEXT _
 m
LINE (256, 24)-STEP(63, 15), 10, B: LINE (257, 25)-STEP(61, 13), 2, B
LINE (254, 59)-STEP(51, 51), 5, B
LINE (253, 58)-STEP(53, 53), 4, B
LINE (269, 56)-STEP(21, 2), 4, B
LINE (270, 56)-STEP(19, 3), 10, BF
LINE (270, 56)-STEP(19, 3), 5, B


LINE (254, 114)-STEP(51, 51), 15, BF: LINE (254, 114)-STEP(51, 51), 9, B: LINE (253, 113)-STEP(53, 53), 1, B
LINE (255, 44)-STEP(10, 10), 9, BF: PSET (255, 44), 0: LINE (257, 47)-STEP(6, 7), 15, BF
LINE (257, 54)-STEP(6, 0), 7: LINE (257, 48)-STEP(6, 0), 7: LINE (257, 50)-STEP(6, 0), 7: LINE (257, 52)-STEP(6, 0), 7: LINE (256, 44)-STEP(9, 0), 3: LINE (255, 45)-STEP(0, 9), 3
CIRCLE (260, 50), 1, 0, 2.28, 5.14: CIRCLE (260, 52), 1, 0, 5.14, 1.57: CIRCLE (261, 50), 1, 0, 2.28, 5.14: CIRCLE (261, 52), 1, 0, 5.14, 1.57: PSET (259, 53), 0
LINE (275, 44)-STEP(10, 10), 1, BF: PSET (275, 44), 0: LINE (277, 47)-STEP(6, 7), 15, BF: LINE (277, 54)-STEP(6, 0), 7
LINE (277, 48)-STEP(6, 0), 7: LINE (277, 50)-STEP(6, 0), 7: LINE (277, 52)-STEP(6, 0), 7: LINE (276, 44)-STEP(9, 0), 9: LINE (275, 45)-STEP(0, 9), 9
LINE (279, 49)-STEP(0, 4), 0: LINE (279, 53)-STEP(3, 0), 0
LINE (295, 44)-STEP(10, 10), 4, BF: PSET (295, 44), 0: LINE (297, 47)-STEP(6, 7), 15, BF: LINE (297, 54)-STEP(6, 0), 7
LINE (297, 48)-STEP(6, 0), 7: LINE (297, 50)-STEP(6, 0), 7: LINE (297, 52)-STEP(6, 0), 7: LINE (296, 44)-STEP(9, 0), 12: LINE (295, 45)-STEP(0, 9), 12
LINE (298, 49)-STEP(4, 4), 0: LINE (302, 49)-STEP(-4, 4), 0
LINE (308, 58)-STEP(10, 10), 7, BF: LINE (308, 58)-STEP(10, 10), 8, B: LINE (308, 58)-STEP(9, 0), 15: LINE (308, 58)-STEP(0, 9), 15
LINE (312, 60)-STEP(3, 3), 0: LINE (312, 66)-STEP(3, -3), 0: LINE (312, 60)-STEP(0, 6), 0: PAINT (313, 63), 0
LINE (308, 70)-STEP(10, 10), 7, BF: LINE (308, 70)-STEP(10, 10), 8, B: LINE (308, 70)-STEP(9, 0), 15: LINE (308, 70)-STEP(0, 9), 15
LINE (314, 72)-STEP(-3, 3), 0: LINE (314, 78)-STEP(-3, -3), 0: LINE (314, 72)-STEP(0, 6), 0: PAINT (313, 74), 0
LINE (308, 82)-STEP(10, 10), 7, BF: LINE (308, 82)-STEP(10, 10), 8, B: LINE (308, 82)-STEP(9, 0), 15: LINE (308, 82)-STEP(0, 9), 15
LINE (310, 88)-STEP(3, -3), 0: LINE (316, 88)-STEP(-3, -3), 0: LINE (310, 88)-STEP(6, 0), 0: PAINT (314, 87), 0
LINE (308, 94)-STEP(10, 10), 7, BF: LINE (308, 94)-STEP(10, 10), 8, B: LINE (308, 94)-STEP(9, 0), 15: LINE (308, 94)-STEP(0, 9), 15
LINE (310, 98)-STEP(3, 3), 0: LINE (316, 98)-STEP(-3, 3), 0: LINE (310, 98)-STEP(6, 0), 0: PAINT (314, 99), 0
LINE (308, 110)-STEP(10, 10), 7, BF: LINE (308, 110)-STEP(10, 10), 8, B: LINE (308, 110)-STEP(9, 0), 15: LINE (308, 110)-STEP(0, 9), 15: LINE (312, 112)-STEP(0, 6), 0: CIRCLE (311, 113), 1, 0: CIRCLE (315, 115), 3, 0, , , 3: PSET (317, 112), 0
LINE (308, 122)-STEP(10, 10), 7, BF: LINE (308, 122)-STEP(10, 10), 8, B: LINE (308, 122)-STEP(9, 0), 15: LINE (308, 122)-STEP(0, 9), 15: LINE (311, 124)-STEP(0, 6), 0: LINE (315, 124)-STEP(0, 6), 0: LINE (311, 124)-STEP(2, 2), 0
LINE (313, 126)-STEP(2, -2), 0: LINE (308, 134)-STEP(10, 10), 7, BF: LINE (308, 134)-STEP(10, 10), 8, B: LINE (308, 134)-STEP(9, 0), 15: LINE (308, 134)-STEP(0, 9), 15: LINE (310, 136)-STEP(6, 6), 0: LINE (316, 136)-STEP(-6, 6), 0
LINE (308, 146)-STEP(10, 10), 7, BF: LINE (308, 146)-STEP(10, 10), 8, B: LINE (308, 146)-STEP(9, 0), 15: LINE (308, 146)-STEP(0, 9), 15: CIRCLE (313, 151), 4, 0: LINE (314, 152)-STEP(2, 2), 0
LINE (310, 48)-STEP(2, 0), 5: LINE -STEP(0, 3), 5: LINE -STEP(-2, 0), 5: LINE -STEP(3, 3), 5: LINE -STEP(3, -3), 5: LINE -STEP(-2, 0), 5: LINE -STEP(0, -3), 5: LINE -STEP(2, 0), 5: LINE -STEP(-3, -3), 5: LINE -STEP(-3, 3), 5: PAINT (313, 50), 13, 5
LINE (309, 159)-STEP(5, 5), 10: PSET (313, 164), 10: PSET (314, 163), 10: LINE (309, 159)-STEP(8, 0), 10: PSET (316, 158), 10: PSET (316, 160), 10: LINE (309, 159)-STEP(0, 7), 10: PSET (308, 165), 10: PSET (310, 165), 10
LINE (256, 0)-STEP(63, 7), 7, BF: LINE (256, 0)-STEP(63, 7), 8, B: LINE (256, 0)-STEP(63, 0), 15, BF: LINE (256, 0)-STEP(0, 6), 15, BF: LINE (266, 0)-STEP(0, 6), 8: LINE (267, 0)-STEP(0, 6), 15: LINE (277, 0)-STEP(0, 6), 8
LINE (278, 0)-STEP(0, 6), 15: LINE (288, 0)-STEP(0, 6), 8: LINE (289, 0)-STEP(0, 6), 15: LINE (299, 0)-STEP(0, 6), 8: LINE (300, 0)-STEP(0, 6), 15: LINE (310, 0)-STEP(0, 6), 8: LINE (311, 0)-STEP(0, 6), 15: LINE (256, 0)-STEP(10, 7), 8, B
LINE (258, 2)-STEP(6, 3), 12: LINE (269, 2)-STEP(6, 3), 4, B: CIRCLE (283, 3), 3, 3: CIRCLE (283, 3), 3, 9, , , .7: LINE (290, 1)-STEP(4, 3), 13, BF: LINE (290, 1)-STEP(4, 3), 5, B: LINE (293, 2)-STEP(4, 3), 13, BF: LINE (293, 2)-STEP(4, 3), 5, B
LINE (305, 2)-STEP(4, 3), 6, BF: LINE (305, 2)-STEP(1, 3), 1, BF: LINE (301, 3)-STEP(3, 1), 1, BF: PSET (313, 4), 5: PSET STEP(1, 1), 5: PSET STEP(1, 0), 5: PSET STEP(1, -1), 5: PSET STEP(0, -1), 5: PSET STEP(1, -1), 5: PSET STEP(1, 1), 5
LINE (310, 106)-STEP(7, 2), 7, B: LINE (307, 107)-STEP(2, -2), 7: LINE (307, 107)-STEP(2, 2), 7: PSET (310, 107), 0: PAINT (310, 107), 15, 7
LINE (284, 173)-STEP(25, 5), 10, B: LINE (309, 173)-STEP(0, 5), 0: LINE (309, 178)-STEP(0, 3), 10: LINE (309, 173)-STEP(0, -3), 10: LINE (309, 181)-STEP(9, -5), 10: LINE (309, 170)-STEP(9, 5), 10: LINE (299, 173)-STEP(0, 5), 10: PAINT (301, 176), 4 _
, 10
PAINT (298, 176), 9, 10: LINE (297, 174)-STEP(0, 3), 5: LINE (298, 174)-STEP(0, 3), 9: LINE (299, 174)-STEP(0, 3), 5: LINE (300, 174)-STEP(0, 3), 5: LINE (301, 174)-STEP(0, 3), 5: LINE (302, 174)-STEP(0, 3), 4: LINE (303, 174)-STEP(0, 3), 5
LINE (254, 169)-STEP(26, 26), 13, B: LINE (253, 168)-STEP(28, 28), 5, B: CIRCLE (296, 185), 8, 1, , , .5: CIRCLE (296, 185), 7, 9, , , .5: PAINT (296, 185), 15, 9
LINE (284, 192)-STEP(24, 4), 4, B: : LINE (285, 193)-STEP(22, 2), 12, B:  LINE (286, 194)-STEP(20, 0), 10
PCOPY 1, 0
MouseShow
aftererror:
SCREEN 7, , 0, 0
LINE (258, 26)-STEP(59, 11), cc2%, BF: LINE (270, 29)-STEP(35, 5), cc1%, BF

DO'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  MouseShow                             '<--calls sub to show the mouse
  MouseStatus lb%, rb%, x%, y%        '<--calls sub MouseStatus to
  IF lb% = -1 OR rb% = -1 THEN MouseHide
  IF a$ = "/" THEN wmb = 1 ELSE IF a$ = "*" THEN wmb = 2 ELSE IF a$ = "-" THEN wmb = 3
  IF x% >= 255 AND y% >= 8 AND y% <= 23 AND lb% = -1 THEN cc1% = POINT(x%, y%): LINE (258, 26)-STEP(59, 11), cc2%, BF: LINE (270, 29)-STEP(35, 5), cc1%, BF
  IF x% >= 255 AND y% >= 8 AND y% <= 23 AND rb% = -1 THEN cc2% = POINT(x%, y%): LINE (258, 26)-STEP(59, 11), cc2%, BF: LINE (270, 29)-STEP(35, 5), cc1%, BF
  IF x% < 250 AND lb% = -1 THEN
	LINE ((INT(x% / 5) * 5) + 1, (INT(y% / 4) * 4) + 1)-STEP(3, 2), cc1%, BF: LINE (0, 0)-STEP(250, 199), 7, B
	IF linkpic = 4 THEN PSET (255 + INT(x% / 5), 60 + INT(y% / 4)), cc1%: IF editmsk <> 4 THEN IF cc1% <> 0 THEN PSET (255 + INT(x% / 5), 115 + INT(y% / 4)), 0 ELSE PSET (255 + INT(x% / 5), 115 + INT(y% / 4)), 15
  ELSEIF x% < 250 AND rb% = -1 THEN
	LINE ((INT(x% / 5) * 5) + 1, (INT(y% / 4) * 4) + 1)-STEP(3, 2), cc2%, BF: LINE (0, 0)-STEP(250, 199), 7, B
	IF linkpic = 4 THEN PSET (255 + INT(x% / 5), 60 + INT(y% / 4)), cc2%: IF editmsk <> 4 THEN IF cc2% <> 0 THEN PSET (255 + INT(x% / 5), 115 + INT(y% / 4)), 0 ELSE PSET (255 + INT(x% / 5), 115 + INT(y% / 4)), 15
  END IF
  IF x% = 319 AND a$ = " " THEN PCOPY 1, 0: LINE (258, 26)-STEP(59, 11), cc2%, BF: LINE (270, 29)-STEP(35, 5), cc1%, BF
 
 
  IF a$ = "~" THEN CLEAR : RUN "C:\QBASIC\SOWSHIT"
 
 
 
  IF a$ = "S" OR (x% >= 255 AND x% <= 265 AND y% >= 44 AND y% <= 54 AND (lb% = -1 OR rb% = -1)) THEN save: wkey: GOSUB resetlr
  IF a$ = "L" OR (x% >= 275 AND x% <= 285 AND y% >= 44 AND y% <= 54 AND (lb% = -1 OR rb% = -1)) THEN load 1: wkey: GOSUB resetlr: IF loaded THEN GOSUB resetpicture2
  IF a$ = "D" OR (x% >= 295 AND x% <= 305 AND y% >= 44 AND y% <= 54 AND (lb% = -1 OR rb% = -1)) THEN delete: wkey: GOSUB resetlr
  IF a$ = "O" OR (x% >= 310 AND x% <= 316 AND y% >= 45 AND y% < 54 AND (POINT(x%, y%) = 13 OR POINT(x%, y%) = 5) AND (lb% = -1 OR rb% = -1)) THEN organizer: wkey
  IF (a$ = "<" OR (x% >= 308 AND x% <= 318 AND y% >= 105 AND y% <= 110 AND (lb% = -1 OR rb% = -1))) AND linkpic <> 4 THEN CALL MouseHide: GOSUB resetpicture2:
  IF (a$ = ">" OR (x% >= 269 AND x% <= 291 AND y% >= 56 AND y% <= 59 AND (lb% = -1 OR rb% = -1))) AND linkpic <> 4 THEN MouseHide: GOSUB resetpicture:
  IF a$ = "M" OR (x% >= 289 AND x% <= 304 AND y% >= 181 AND y% <= 190 AND (lb% = -1 OR rb% = -1)) THEN SWAP editmsk, oeditmsk: PAINT (296, 185), editmsk, 9: killmouse
  IF a$ = rght$ OR (x% >= 308 AND x% <= 318 AND y% >= 58 AND y% <= 68 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: FOR B% = 0 TO 48: FOR bb% = 0 TO 49: LINE ((B% + 1) * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = lft$ OR (x% >= 308 AND x% <= 318 AND y% >= 70 AND y% <= 80 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: FOR B% = 1 TO 49: FOR bb% = 0 TO 49: LINE ((B% - 1) * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = up$ OR (x% >= 308 AND x% <= 318 AND y% >= 82 AND y% <= 92 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: FOR B% = 0 TO 49: FOR bb% = 1 TO 49: LINE (B% * 5 + 1, (bb% - 1) * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = dwn$ OR (x% >= 308 AND x% <= 318 AND y% >= 94 AND y% <= 104 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: FOR B% = 0 TO 49: FOR bb% = 0 TO 48: LINE (B% * 5 + 1, (bb% + 1) * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = "P" OR (x% >= 284 AND x% <= 309 AND y% >= 192 AND y% <= 197 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: SWAP linkpic, olinkpic: LINE (271, 57)-STEP(17, 1), linkpic, BF: IF linkpic = 4 THEN LINE (286, 194)-STEP(20, 0), 4 ELSE LINE (286, 194)-STEP(20, 0), 10
	IF a$ <> "P" THEN killmouse:
  ELSEIF a$ = "(" OR (x% >= 308 AND x% <= 318 AND y% >= 110 AND y% <= 120 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: D% = -1: FOR B% = 0 TO 49: c% = 50: D% = D% + 1: FOR bb% = 0 TO 49: c% = c% - 1: LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + c%, 60 + D%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = ")" OR (x% >= 308 AND x% <= 318 AND y% >= 122 AND y% <= 132 AND (lb% = -1 OR rb% = -1)) THEN
	GOSUB resetpicture: c% = 50: FOR B% = 0 TO 49: c% = c% - 1: FOR bb% = 0 TO 49: LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + c%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%: GOSUB resetpicture
  ELSEIF a$ = "C" OR (x% >= 308 AND x% <= 318 AND y% >= 134 AND y% <= 144 AND (lb% = -1 OR rb% = -1)) THEN
		LINE (252, 167)-STEP(80, 50), 0, BF: DO: LOCATE 22, 33: COLOR 10: PRINT "-CLEAR-": LOCATE 23, 33: COLOR 2: PRINT " (Y/N)  ": a$ = UCASE$(INKEY$): LOOP UNTIL a$ = "Y" OR a$ = "N" OR a$ = CHR$(27)
		IF a$ = "Y" THEN MouseHide: PCOPY 1, 0: LINE (258, 26)-STEP(59, 11), cc2%, BF: LINE (270, 29)-STEP(35, 5), cc1%, BF:  ELSE IF a$ = "N" OR a$ = CHR$(27) THEN GOSUB resetlr
  ELSEIF a$ = "Q" OR (x% >= 308 AND x% <= 318 AND y% >= 146 AND y% <= 156 AND (lb% = -1 OR rb% = -1)) THEN
endplace:
		LINE (252, 167)-STEP(80, 50), 0, BF: DO: LOCATE 22, 33: COLOR 10: PRINT "Q U I T": LOCATE 23, 33: COLOR 2: PRINT " (Y/N)  ": a$ = UCASE$(INKEY$): LOOP UNTIL a$ = "Y" OR a$ = "N" OR a$ = CHR$(27)
		IF a$ = "Y" OR a$ = CHR$(27) THEN COLOR 15: GOTO STOPPROGRAM:   ELSE IF a$ = "N" THEN GOSUB resetlr:
  ELSEIF a$ = "&" OR (x% >= 284 AND x% <= 315 AND y% >= 173 AND y% <= 179 AND (lb% = -1 OR rb% = -1)) THEN
	CALL MouseHide: FOR B% = 0 TO 49: FOR bb% = 0 TO 49: IF POINT(B% * 5 + 2, bb% * 4 + 2) = cc1% THEN LINE ((B% * 5) + 1, (bb% * 4) + 1)-STEP(3, 2), cc2%, BF
	NEXT bb%: NEXT B%: IF linkpic = 4 THEN GOSUB resetpicture:
  ELSEIF a$ = "?" OR (x% >= 309 AND x% <= 316 AND y% >= 159 AND y% <= 166 AND (lb% = -1 OR rb% = -1)) THEN
	CALL MouseHide: FOR B% = 0 TO 24: FOR bb% = 0 TO 24: PSET (280 + B%, 60 + bb%), POINT(255 + B%, 60 + bb%): PSET (255 + B%, 85 + bb%), POINT(255 + B%, 60 + bb%): PSET (280 + B%, 85 + bb%), POINT(255 + B%, 60 + bb%): NEXT bb%: NEXT B%
	FOR B% = 0 TO 49: FOR bb% = 0 TO 49: LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: LINE (0, 0)-STEP(250, 199), 7, B: NEXT bb%: NEXT B%
  END IF
	'select small pic editor
  IF a$ = "!" OR a$ = "@" OR a$ = "#" OR a$ = "$" OR a$ = "%" OR a$ = "^" OR (x% >= 256 AND y% <= 7 AND (lb% OR rb%)) THEN
	LINE (256, 0)-STEP(63, 7), 8, B: LINE (256, 0)-STEP(63, 0), 15, BF: LINE (256, 0)-STEP(0, 6), 15, BF: LINE (266, 0)-STEP(0, 6), 8: LINE (267, 0)-STEP(0, 6), 15: LINE (277, 0)-STEP(0, 6), 8
	LINE (278, 0)-STEP(0, 6), 15: LINE (288, 0)-STEP(0, 6), 8: LINE (289, 0)-STEP(0, 6), 15: LINE (299, 0)-STEP(0, 6), 8: LINE (300, 0)-STEP(0, 6), 15: LINE (310, 0)-STEP(0, 6), 8: LINE (311, 0)-STEP(0, 6), 15
  END IF
  IF a$ = "!" OR (x% >= 256 AND x% <= 266 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 1: LINE (256, 0)-STEP(10, 7), 8, B
  IF a$ = "@" OR (x% >= 267 AND x% <= 277 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 2: LINE (267, 0)-STEP(10, 7), 8, B
  IF a$ = "#" OR (x% >= 278 AND x% <= 288 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 3: LINE (278, 0)-STEP(10, 7), 8, B
  IF a$ = "$" OR (x% >= 289 AND x% <= 299 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 4: LINE (289, 0)-STEP(10, 7), 8, B
  IF a$ = "%" OR (x% >= 300 AND x% <= 310 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 5: LINE (300, 0)-STEP(10, 7), 8, B
  IF a$ = "^" OR (x% >= 311 AND x% <= 320 AND y% >= 0 AND y% <= 7 AND (lb% = -1 OR rb% = -1)) THEN msfct = 6: LINE (311, 0)-STEP(9, 7), 8, B
	'small picture editor options
  IF x% >= 255 AND x% <= 304 AND y% >= 60 AND y% <= 109 AND (lb% = -1 OR rb% = -1) THEN
	'line-------------------------
	IF msfct = 1 THEN
	  px1 = x%: py1 = y%: pc1 = POINT(px1, py1): IF lb% = -1 THEN PSET (px1, py1), cc1%:  ELSE PSET (px1, py1), cc2%
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	  DO: MouseShow: MouseStatus lb%, rb%, x%, y%: IF x% < 255 OR x% > 305 OR y% < 60 OR y% > 110 THEN MouseHide: PSET (px1, py1), pc1: GOTO donefct:
	  LOOP UNTIL lb% = -1 OR rb% = -1: CALL MouseHide: px2 = x%: py2 = y%: IF lb% = -1 THEN pc1 = cc1%:  ELSE pc1 = cc2%
	  LINE (px1, py1)-(px2, py2), pc1: DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	'box-------------------------
	ELSEIF msfct = 2 THEN
	  px1 = x%: py1 = y%: pc1 = POINT(px1, py1): IF lb% = -1 THEN PSET (px1, py1), cc1%:  ELSE PSET (px1, py1), cc2%
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	  DO: MouseShow: MouseStatus lb%, rb%, x%, y%: IF x% < 255 OR x% > 305 OR y% < 60 OR y% > 110 THEN MouseHide: PSET (px1, py1), pc1: GOTO donefct:
	  LOOP UNTIL lb% = -1 OR rb% = -1: CALL MouseHide: px2 = x%: py2 = y%: IF lb% = -1 THEN LINE (px1, py1)-(px2, py2), cc1%, B ELSE LINE (px1, py1)-(px2, py2), cc2%, BF
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	'circle-------------------------
	ELSEIF msfct = 3 THEN
	  px1 = x%: py1 = y%: pc1 = POINT(px1, py1): IF lb% = -1 THEN PSET (px1, py1), cc1%:  ELSE PSET (px1, py1), cc2%
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	  DO: MouseShow: MouseStatus lb%, rb%, x%, y%: cr = CINT(SQR(ABS(px1 - x%) ^ 2 + ABS(py1 - y%) ^ 2)): IF px1 - cr < 255 OR px1 + cr > 305 OR py1 - cr < 60 OR py1 + cr > 110 THEN CALL MouseHide: PSET (px1, py1), pc1: GOTO donefct:
	  LOOP UNTIL lb% = -1 OR rb% = -1: CALL MouseHide: PSET (px1, py1), pc1: IF lb% = -1 THEN pc1 = cc1%:  ELSE pc1 = cc2%
	  CIRCLE (px1, py1), cr, pc1: DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	'get/put-------------------------
	ELSEIF msfct = 4 THEN
	  px1 = INT((x% - 255) / 25): py1 = INT((y% - 60) / 25)
	  IF lb% THEN GET (255 + px1 * 25, 60 + py1 * 25)-STEP(24, 24), getpict: PUT (255, 170), getpict, PSET
	  IF rb% THEN PUT (255 + px1 * 25, 60 + py1 * 25), getpict, PSET
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	'paint-------------------------
	ELSEIF msfct = 5 THEN
	  IF lb% THEN LINE (254, 59)-STEP(51, 51), cc2%, B: PAINT (x%, y%), cc1%, cc2%: LINE (254, 59)-STEP(51, 51), 12, B
	  IF rb% THEN LINE (254, 59)-STEP(51, 51), cc1%, B: PAINT (x%, y%), cc2%, cc1%: LINE (254, 59)-STEP(51, 51), 12, B
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	'free hand-------------------------
	ELSEIF msfct = 6 THEN
	  IF lb% THEN PSET (x%, y%), cc1% ELSE IF rb% THEN PSET (x%, y%), cc2%
	END IF
	IF linkpic = 4 THEN GOSUB resetpicture2:
donefct:
  ELSEIF x% >= 255 AND x% <= 304 AND y% >= 115 AND y% <= 164 AND (lb% = -1 OR rb% = -1) THEN
	IF msfct = 5 THEN
	  IF lb% THEN LINE (254, 114)-STEP(51, 51), 0, B: PAINT (x%, y%), 0, 0: LINE (254, 114)-STEP(51, 51), 9, B:
	  IF rb% THEN LINE (254, 114)-STEP(51, 51), 15, B: PAINT (x%, y%), 15, 15: LINE (254, 114)-STEP(51, 51), 9, B:
	  DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
	ELSEIF msfct = 6 THEN
	  IF lb% THEN PSET (x%, y%), 0 ELSE IF rb% THEN PSET (x%, y%), 15
	END IF
  END IF
  MouseShow
  IF a$ = CHR$(27) THEN GOTO endplace:
a$ = UCASE$(INKEY$): LOOP'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




IF 5 = 6 THEN
resetpicture:
  CALL MouseHide:
  FOR B% = 0 TO 49: FOR bb% = 0 TO 49: PSET (255 + B%, 60 + bb%), POINT(B% * 5 + 2, bb% * 4 + 2): NEXT bb%: NEXT B%
  IF editmsk <> 4 THEN
	FOR B% = 0 TO 49: FOR bb% = 0 TO 49: cococ = 0
	IF POINT(B% * 5 + 2, bb% * 4 + 2) = 0 THEN cococ = 15
	PSET (255 + B%, 115 + bb%), cococ: NEXT bb%: NEXT B%
  END IF
  RETURN
resetpicture2:
  FOR B% = 0 TO 49: FOR bb% = 0 TO 49: LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF: NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%
  RETURN
resetlr:
  LINE (252, 167)-STEP(80, 50), 0, BF: LINE (284, 173)-STEP(25, 5), 10, B: LINE (309, 173)-STEP(0, 5), 0: LINE (309, 178)-STEP(0, 3), 10: LINE (309, 173)-STEP(0, -3), 10: LINE (309, 181)-STEP(9, -5), 10: LINE (309, 170)-STEP(9, 5), 10
  LINE (299, 173)-STEP(0, 5), 10: PAINT (301, 176), 4, 10: PAINT (298, 176), 9, 10: LINE (297, 174)-STEP(0, 3), 5: LINE (298, 174)-STEP(0, 3), 9: LINE (299, 174)-STEP(0, 3), 5: LINE (300, 174)-STEP(0, 3), 5: LINE (301, 174)-STEP(0, 3), 5
  LINE (302, 174)-STEP(0, 3), 4: LINE (303, 174)-STEP(0, 3), 5: LINE (254, 169)-STEP(26, 26), 13, B: LINE (253, 168)-STEP(28, 28), 5, B: CIRCLE (296, 185), 8, 1, , , .5: CIRCLE (296, 185), 7, 9, , , .5: PAINT (296, 185), editmsk, 9
  PUT (255, 170), getpict, PSET: LINE (284, 192)-STEP(24, 4), 4, B: LINE (285, 193)-STEP(22, 2), 12, B: LINE (286, 194)-STEP(20, 0), linkpic
  RETURN
END IF
LINE (260, 170)-STEP(25, 5), 10, B: LINE (285, 170)-STEP(0, 5), 0: LINE (285, 175)-STEP(0, 3), 10: LINE (285, 170)-STEP(0, -3), 10: LINE (285, 178)-STEP(9, -5), 10: LINE (285, 167)-STEP(9, 5), 10: LINE (275, 170)-STEP(0, 5), 10: PAINT (274, 172), 9 _
, 10:
PAINT (276, 172), 4, 10: LINE (273, 171)-STEP(0, 3), 5: LINE (274, 171)-STEP(0, 3), 9: LINE (275, 171)-STEP(0, 3), 5: LINE (276, 171)-STEP(0, 3), 5: LINE (277, 171)-STEP(0, 3), 5: LINE (278, 171)-STEP(0, 3), 4: LINE (279, 171)-STEP(0, 3), 5:
STOPPROGRAM:
SYSTEM

SUB ascii
'           Regular ASCII Chart (character codes 0 - 127)
'000   (nul)  016  (dle)  032 sp  048 0  064 @  080 P  096 `  112 p
'001  (soh)  017  (dc1)  033 !   049 1  065 A  081 Q  097 a  113 q
'002  (stx)  018  (dc2)  034 "   050 2  066 B  082 R  098 b  114 r
'003  (etx)  019  (dc3)  035 #   051 3  067 C  083 S  099 c  115 s
'004  (eot)  020  (dc4)  036 $   052 4  068 D  084 T  100 d  116 t
'005  (enq)  021  (nak)  037 %   053 5  069 E  085 U  101 e  117 u
'006  (ack)  022  (syn)  038 &   054 6  070 F  086 V  102 f  118 v
'007  (bel)  023  (etb)  039 '   055 7  071 G  087 W  103 g  119 w
'008  (bs)   024  (can)  040 (   056 8  072 H  088 X  104 h  120 x
'009   (tab)  025  (em)   041 )   057 9  073 I  089 Y  105 i  121 y
'010   (lf)   026   (eof)  042 *   058 :  074 J  090 Z  106 j  122 z
'011  (vt)   027  (esc)  043 +   059 ;  075 K  091 [  107 k  123 {
'012  (np)   028  (fs)   044 ,   060 <  076 L  092 \  108 l  124 |
'013   (cr)   029  (gs)   045 -   061 =  077 M  093 ]  109 m  125 }
'014  (so)   030  (rs)   046 .   062 >  078 N  094 ^  110 n  126 ~
'015  (si)   031  (us)   047 /   063 ?  079 O  095 _  111 o  127 

'33-126



												   

'            Extended ASCII Chart (character codes 128 - 255)
'128 €      144       160      176 °    192 À    208 Ð    224 à   240 ð
'129       145 ‘      161 ¡    177 ±    193 Á    209 Ñ    225 á   241 ñ
'130 ‚      146 ’      162 ¢    178 ²    194 Â    210 Ò    226 â   242 ò
'131 ƒ      147 “      163 £    179 ³    195 Ã    211 Ó    227 ã   243 ó
'132 „      148 ”      164 ¤    180 ´    196 Ä    212 Ô    228 ä   244 ô
'133 …      149 •      165 ¥    181 µ    197 Å    213 Õ    229 å   245 õ
'134 †      150 –      166 ¦    182 ¶    198 Æ    214 Ö    230 æ   246 ö
'135 ‡      151 —      167 §    183 ·    199 Ç    215 ×    231 ç   247 ÷
'136 ˆ      152 ˜      168 ¨    184 ¸    200 È    216 Ø    232 è   248 ø
'137 ‰      153 ™      169 ©    185 ¹    201 É    217 Ù    233 é   249 ù
'138 Š      154 š      170 ª    186 º    202 Ê    218 Ú    234 ê   250 ú
'139 ‹      155 ›      171 «    187 »    203 Ë    219 Û    235 ë   251 û
'140 Œ      156 œ      172 ¬    188 ¼    204 Ì    220 Ü    236 ì   252 ü
'141       157       173 ­    189 ½    205 Í    221 Ý    237 í   253 ý
'142 Ž      158 ž      174 ®    190 ¾    206 Î    222 Þ    238 î   254 þ
'143       159 Ÿ      175 ¯    191 ¿    207     223 ß    239 ï   255
'UP-------CHR$(0) + CHR$(72)
'DOWN-----CHR$(0) + CHR$(80)
'LEFT-----CHR$(0) + CHR$(75)
'RIGHT----CHR$(0) + CHR$(77)
'ENTER----CHR$(13)
'ESC------CHR$(27)
'BCK SPC--CHR$(8)
'DELETE---CHR$(0) + CHR$(83)
'SPACE----CHR$(32)
'F1-------CHR$(0) + CHR$(59)
'F2-------CHR$(0) + CHR$(60)
'F3-------CHR$(0) + CHR$(61)
'F4-------CHR$(0) + CHR$(62)



END SUB

SUB delete
LINE (252, 167)-STEP(80, 50), 0, BF
LOCATE 22, 33: COLOR 2: PRINT "-"; : COLOR 10: PRINT "LIST"; : COLOR 2: PRINT "-"
finp 33, 23, 10
list$ = LTRIM$(RTRIM$(aa$)): IF LEN(list$) = 0 THEN EXIT SUB
fuckupsomemore:
	  SCREEN 7, , 3, 3: CLS
	  LINE (10, 6)-STEP(299, 165), 1, B: LINE (9, 5)-STEP(301, 167), 5, B
	  LOCATE 1, 2: COLOR 1: PRINT "Ü": LOCATE 1, 39: COLOR 1: PRINT "Ü"
	  LOCATE 1, 14: COLOR 4:  PRINT "D": LOCATE 1, 15: COLOR 12: PRINT "E": LOCATE 1, 16: COLOR 14: PRINT "L"
	  LOCATE 1, 17: COLOR 15: PRINT "E": LOCATE 1, 18: COLOR 14: PRINT "T": LOCATE 1, 19: COLOR 12: PRINT "E"
	  LOCATE 1, 21: COLOR 4: PRINT "F": LOCATE 1, 22: COLOR 12: PRINT "I": LOCATE 1, 23: COLOR 14: PRINT "L"
	  LOCATE 1, 24: COLOR 15: PRINT "E"
	  COLOR 8: FOR t = 1 TO LEN(list$): LOCATE 21 - LEN(list$) + t, 1: PRINT MID$(list$, t, 1): NEXT t
	  REDIM picture(0 TO 3800), picturem(0 TO 3800)
	  REDIM gfxfile$(60), picture2(3800), picturem2(3800)
	  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR INPUT AS #1: nof = 1: lnx = 0: lny = 0
	  FOR lnn = 1 TO 59
		INPUT #1, gfxfile$(lnn): gfxfile$(lnn) = UCASE$(gfxfile$(lnn))
		LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT gfxfile$(lnn)
		IF LEN(gfxfile$(lnn)) > 0 THEN lny = lny + 1: nof = nof + 1
		IF lny = 20 THEN lnx = lnx + 10: lny = 0
	  NEXT lnn: CLOSE #1: gfxfile$(nof) = "<CANCLE>": LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "CANCLE"; : COLOR 11: PRINT ">"
	  yy = 1: xx = 1: nor = 3 - INT((60 - nof) / 20)
	  DO
		IF c$ = up$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy - 1
		IF c$ = dwn$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy + 1
		IF c$ = lft$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx - 1
		IF c$ = rght$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx + 1
		IF xx <= 0 THEN xx = nor ELSE IF xx > nor THEN xx = 1 ELSE IF yy > 20 THEN yy = 1
		IF c$ = dwn$ AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = 1
		IF (c$ = rght$ OR c$ = lft$) AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = nof - ((nor - 1) * 20)
		IF yy <= 0 AND xx <> nor THEN yy = 20 ELSE IF yy <= 0 AND xx = nor THEN yy = nof - ((nor - 1) * 20)
		LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 2: PRINT "Í"; : COLOR 10: PRINT ""
	  c$ = INKEY$: LOOP UNTIL c$ = " " OR c$ = CHR$(13) OR c$ = CHR$(27): name$ = gfxfile$((xx - 1) * 20 + yy)
	  IF c$ = CHR$(27) OR name$ = "<CANCLE>" THEN GOTO dontkil:
	  LOCATE 23, 1: COLOR 4: PRINT STRING$(40, "Ä"): LOCATE 23, 1: PRINT "": LOCATE 23, 40: PRINT ""
	  LOCATE 23, 11: : COLOR 4: PRINT "¿D"; : COLOR 12: PRINT "E"; : COLOR 14: PRINT "L"; : COLOR 15: PRINT "E";
	  COLOR 14: PRINT "T"; : COLOR 12: PRINT "E "; : COLOR 7: PRINT name$;
	  COLOR 5: PRINT " ("; : COLOR 10: PRINT "Y"; : COLOR 5: PRINT "/"; : COLOR 10: PRINT "N"; : COLOR 5: PRINT ")"; : COLOR 4: PRINT "Ú";
	  DO: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27) OR a$ = "Y" OR a$ = "N"
	  IF a$ = "N" OR a$ = CHR$(27) THEN GOTO dontkil:
	  trig = 0
	  FOR t = 1 TO 59
		IF gfxfile$(t) = name$ THEN trig = 1
		IF trig THEN gfxfile$(t) = gfxfile$(t + 1): IF gfxfile$(t) = "<CANCLE>" THEN gfxfile$(t) = ""
	  NEXT t: gfxfile$(59) = ""
	  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR OUTPUT AS #1
	  FOR t = 1 TO 59: WRITE #1, gfxfile$(t): NEXT t: CLOSE #1
	  KILL "C:\qbasic\grafix\" + list$ + "\" + name$ + ".PIC"
	  ERASE gfxfile$
	  SCREEN 7, , 4, 4: CLS : LOCATE 12, 13 - INT(LEN(name$) * .5): COLOR 4: PRINT "FILE "; : COLOR 3: PRINT name$; : COLOR 4: PRINT " DELETED"
	  LOCATE 14, 14: COLOR 4: PRINT "DELETE MORE?": LOCATE 15, 17: COLOR 3: PRINT "("; : COLOR 10: PRINT "Y"; : COLOR 3: PRINT "/"; : COLOR 10: PRINT "N"; : COLOR 3: PRINT ")"
	  DO: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = "Y" OR a$ = "N" OR a$ = CHR$(27)
	  IF a$ = "Y" THEN GOTO fuckupsomemore:
dontkil:
SCREEN 7, , 0, 0
END SUB

SUB finp (xx, yy, cc)
  aa$ = "": IF cc <> 7 THEN cc2 = cc - 8 ELSE cc2 = 8
  DO: LOOP UNTIL INKEY$ = ""
  DO
	cf = cf + .01 + (LEN(aa$) * .0015): IF cf >= 10 THEN cf = -10
	a$ = UCASE$(INKEY$): IF LEN(a$) THEN a = ASC(a$)
	IF LEN(aa$) < 7 THEN IF (a >= 48 AND a <= 57) OR (a >= 65 AND a <= 90) OR (a >= 97 AND a <= 122) OR a = 95 THEN aa$ = aa$ + a$
	IF LEN(aa$) >= 1 AND (a$ = CHR$(8) OR a$ = CHR$(0) + CHR$(83)) THEN aa$ = MID$(aa$, 1, LEN(aa$) - 1): LOCATE yy, xx + 1 + LEN(aa$): PRINT " "
	LOCATE yy, xx: COLOR cc: PRINT aa$; : COLOR cc2: IF cf > 0 THEN PRINT "Û" ELSE PRINT " "
  LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27): LOCATE yy, xx + LEN(aa$): PRINT " "
END SUB

SUB killmouse
DO: MouseStatus lb%, rb%, x%, y%: LOOP UNTIL lb% = 0 AND rb% = 0
END SUB

SUB load (fun)
loaded = 0
IF fun THEN
LINE (252, 167)-STEP(80, 50), 0, BF
LOCATE 22, 33: COLOR 2: PRINT "-"; : COLOR 10: PRINT "LIST"; : COLOR 2: PRINT "-"
finp 33, 23, 10
END IF
IF LEN(aa$) THEN list$ = LTRIM$(RTRIM$(aa$))
IF LEN(list$) = 0 OR a$ = CHR$(27) THEN EXIT SUB
	  SCREEN 7, , 7, 7: CLS
	  LINE (10, 6)-STEP(299, 165), 5, B: LINE (9, 5)-STEP(301, 167), 1, B
	  LOCATE 1, 2: COLOR 1: PRINT "Ü": LOCATE 1, 39: COLOR 1: PRINT "Ü"
	  LOCATE 1, 16: COLOR 2:  PRINT "L": LOCATE 1, 17: COLOR 10: PRINT "O"
	  LOCATE 1, 18: COLOR 14: PRINT "A": LOCATE 1, 19: COLOR 15: PRINT "D"
	  LOCATE 1, 21: COLOR 15: PRINT "F": LOCATE 1, 22: COLOR 14: PRINT "I"
	  LOCATE 1, 23: COLOR 10: PRINT "L": LOCATE 1, 24: COLOR 2:  PRINT "E"
	  COLOR 8: FOR t = 1 TO LEN(list$): LOCATE 21 - LEN(list$) + t, 38: PRINT MID$(list$, t, 1): NEXT t
	  REDIM picture(0 TO 3800), picturem(0 TO 3800)
	  REDIM gfxfile$(60), picture2(3800), picturem2(3800)
	  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR INPUT AS #1: nof = 1: lnx = 0: lny = 0
	  FOR lnn = 1 TO 59
		INPUT #1, gfxfile$(lnn): gfxfile$(lnn) = UCASE$(gfxfile$(lnn))
		LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT gfxfile$(lnn)
		IF LEN(gfxfile$(lnn)) > 0 THEN lny = lny + 1: nof = nof + 1
		IF lny = 20 THEN lnx = lnx + 10: lny = 0
	  NEXT lnn: CLOSE #1: gfxfile$(nof) = "<CANCLE>": LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "CANCLE"; : COLOR 11: PRINT ">"
	  yy = 1: xx = 1: nor = 3 - INT((60 - nof) / 20)
	  DO
		IF c$ = up$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy - 1
		IF c$ = dwn$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy + 1
		IF c$ = lft$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx - 1
		IF c$ = rght$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx + 1
		IF xx <= 0 THEN xx = nor ELSE IF xx > nor THEN xx = 1 ELSE IF yy > 20 THEN yy = 1
		IF c$ = dwn$ AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = 1
		IF (c$ = rght$ OR c$ = lft$) AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = nof - ((nor - 1) * 20)
		IF yy <= 0 AND xx <> nor THEN yy = 20 ELSE IF yy <= 0 AND xx = nor THEN yy = nof - ((nor - 1) * 20)
		LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 2: PRINT "Í"; : COLOR 10: PRINT ""
	  c$ = INKEY$: LOOP UNTIL c$ = " " OR c$ = CHR$(13) OR c$ = CHR$(27): name$ = gfxfile$((xx - 1) * 20 + yy)
	  IF c$ = CHR$(27) OR name$ = "<CANCLE>" THEN GOTO dontload:
	  MouseHide
	  ERASE gfxfile$
	  OUT &H3C8, 21: OUT &H3C9, 63: OUT &H3C9, 36: OUT &H3C9, 22 ' s k i n  COLOR 13
	  DEF SEG = VARSEG(picture(0))
	  BLOAD "C:\qbasic\grafix\" + list$ + "\" + name$ + ".PIC", VARPTR(picture(0))
	  PUT (1, 1), picture, PSET
	  GET (1, 1)-(50, 50), picture2: GET (51, 1)-STEP(49, 49), picturem2
IF fun THEN
SCREEN 7, , 0, 0
PUT (255, 60), picture2, PSET
PUT (255, 115), picturem2, PSET
LOCATE 22, 33: COLOR 10: PRINT "LOADING": LOCATE 23, 33: COLOR 2: PRINT name$
MouseHide
FOR B% = 0 TO 49: FOR bb% = 0 TO 49
  LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF
NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%
loaded = 1
dontload:
SCREEN 7, , 0, 0
END IF
END SUB

SUB MouseDriver (ax%, bx%, cx%, dx%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(ax%, bx%, cx%, dx%, mouse%)
END SUB

SUB MouseHide
 ax% = 2
 MouseDriver ax%, 0, 0, 0
END SUB

FUNCTION mouseInit%
  ax% = 0
  MouseDriver ax%, 0, 0, 0
  mouseInit% = ax%
END FUNCTION

SUB MouseShow
  ax% = 1
  MouseDriver ax%, 0, 0, 0

END SUB

SUB MouseStatus (lb%, rb%, xMouse%, yMouse%)
  ax% = 3
  MouseDriver ax%, bx%, cx%, dx%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xMouse% = cx% / 2
  yMouse% = dx%

END SUB

SUB organizer
y = 1
toporganizer:
DO: LOOP UNTIL INKEY$ = ""
REDIM thing$(60)
aa$ = "": list$ = ""
SCREEN 7, , 3, 3: CLS
LINE (0, 3)-STEP(170, 73), 4, B
LINE (1, 4)-STEP(168, 71), 5, B
LOCATE 2, 4: COLOR 1:  PRINT "MAKE NEW LIST"
LOCATE 3, 4: COLOR 5:  PRINT "ERASE A LIST"
LOCATE 4, 4: COLOR 13: PRINT "RENAME A LIST"
LOCATE 5, 4: COLOR 11: PRINT "LOAD FROM DISK"
LOCATE 6, 4: COLOR 13: PRINT "ORGANIZE A LIST"
LOCATE 7, 4: COLOR 5:  PRINT "VIEW LISTS"
LOCATE 8, 4: COLOR 1:  PRINT "ORGANIZE PICS"
LOCATE 9, 4: COLOR 8:  PRINT "<DONE>"
DO
  IF a$ <> "" THEN : LOCATE 1 + y, 2: PRINT "  "
  IF a$ = dwn$ THEN y = y + 1 ELSE IF a$ = up$ THEN y = y - 1
  IF y = 0 THEN y = 8 ELSE IF y = 9 THEN y = 1
  LOCATE 1 + y, 2: COLOR 3: PRINT "Í"; : COLOR 10: PRINT ""
  IF y = 1 THEN f$ = "O" ELSE IF y = 2 THEN f$ = "P" ELSE IF y = 3 THEN f$ = "T" ELSE IF y = 4 THEN f$ = "I" ELSE IF y = 5 THEN f$ = "O" ELSE IF y = 6 THEN f$ = "N" ELSE IF y = 7 THEN f$ = "S" ELSE IF y = 8 THEN f$ = " "
  LOCATE 1 + y, 21: COLOR 8: PRINT f$
a$ = INKEY$: LOOP UNTIL a$ = " " OR a$ = CHR$(27)
LOCATE 1 + y, 2: COLOR 8: PRINT "Í"; : COLOR 8: PRINT ""
IF y = 8 OR a$ = CHR$(27) THEN SCREEN 7, , 0, 0: EXIT SUB
'make new list------------------------------------------------------------------------------------
IF y = 1 THEN
  LOCATE 11, 6: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "NAME LIST": LOCATE 12, 6: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  finp 8, 12, 10
  IF LEN(aa$) = 0 OR a$ = CHR$(27) THEN GOTO toporganizer:
  list$ = aa$: REDIM thing$(60)
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1: nof = 0
  FOR B = 1 TO 59: INPUT #1, thing$(B): IF LEN(thing$(B)) THEN nof = nof + 1
	IF thing$(B) = UCASE$(list$) THEN CLOSE #1: LOCATE 11: PRINT STRING$(30, " "): LOCATE 12: PRINT STRING$(30, " "): LOCATE 11: COLOR 4: PRINT " LIST ALREADY EXISTS": SLEEP 2: GOTO toporganizer:
  NEXT B: CLOSE #1: thing$(nof + 1) = UCASE$(list$)
  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR OUTPUT AS #1
  FOR t = 1 TO 59: WRITE #1, "": NEXT t: CLOSE #1
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR OUTPUT AS #1
  FOR B = 1 TO 59: WRITE #1, thing$(B): NEXT B: CLOSE #1
  MKDIR "c:\QBASIC\GRAFIX\" + list$
  LOCATE 11: PRINT STRING$(30, " "): LOCATE 12: PRINT STRING$(30, " "): LOCATE 11: COLOR 3: PRINT " LIST "; : COLOR 10: PRINT list$; : COLOR 3: PRINT " CREATED": SLEEP 2
  CLOSE #1: GOTO toporganizer:
'erase a list---------------------------------------------------------------------------------------------------------
ELSEIF y = 2 THEN
  LOCATE 11, 6: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "LIST TO ERASE": LOCATE 12, 6: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  finp 8, 12, 10
  IF LEN(aa$) = 0 OR a$ = CHR$(27) THEN GOTO toporganizer:
  list$ = aa$: REDIM thing$(60)
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1: nof = 0: fte = 0
  FOR B = 1 TO 59: INPUT #1, thing$(B): IF LEN(thing$(B)) THEN nof = nof + 1
	IF thing$(B) = UCASE$(list$) THEN fte = 1
  NEXT B: CLOSE #1: thing$(nof + 1) = UCASE$(list$)
  IF fte = 0 THEN COLOR 4: LOCATE 11: PRINT "  LIST DOESN'T EXIST": LOCATE 12: PRINT "  FUCK YOURSELF": SLEEP 2: GOTO toporganizer
  LOCATE 11: COLOR 3: PRINT "  ERASE "; : COLOR 10: PRINT list$; : COLOR 3: PRINT " AND ALL"
  LOCATE 12: COLOR 3: PRINT "  FILES IN IT? ("; : COLOR 10: PRINT "Y"; : COLOR 3: PRINT "/"; : COLOR 10: PRINT "N"; : COLOR 3: PRINT ")"
  DO: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = "Y" OR a$ = "N" OR a$ = CHR$(27)
  IF a$ = "N" OR a$ = CHR$(27) THEN : GOTO toporganizer
  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR INPUT AS #1
  FOR B = 1 TO 59: INPUT #1, thing$(B): IF LEN(thing$(B)) THEN KILL "C:\QBASIC\GRAFIX\" + list$ + "\" + thing$(B) + ".PIC"
  NEXT B: CLOSE #1
  KILL "C:\QBASIC\GRAFIX\" + list$ + ".KYX": RMDIR "C:\QBASIC\GRAFIX\" + list$
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1
  nof = 0: FOR B = 1 TO 59: INPUT #1, thing$(B - nof): IF thing$(B) = list$ THEN nof = 1
  NEXT B: thing$(59) = "": CLOSE #1
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR OUTPUT AS #1: FOR B = 1 TO 59: WRITE #1, thing$(B): NEXT B: CLOSE #1
  LOCATE 11: PRINT STRING$(30, " "): LOCATE 12: PRINT STRING$(30, " "): LOCATE 11: COLOR 3: PRINT " LIST "; : COLOR 10: PRINT list$; : COLOR 3: PRINT " ERASED": SLEEP 2
  GOTO toporganizer:
'rename a list---------------------------------------------------------------------------------------------------------
ELSEIF y = 3 THEN
  LOCATE 11, 6: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "OLD LIST NAME": LOCATE 12, 6: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  finp 8, 12, 10: olist$ = aa$: IF a$ = CHR$(27) OR LEN(olist$) = 0 THEN GOTO toporganizer
  LOCATE 11, 6: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "NEW LIST NAME": LOCATE 12, 6: COLOR 8: PRINT "Æ"; : COLOR 8: PRINT ""; : COLOR 2: PRINT olist$; : COLOR 8: PRINT " TO": LOCATE 13, 6: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  finp 8, 13, 10: nlist$ = aa$: IF a$ = CHR$(27) OR LEN(olist$) = 0 THEN GOTO toporganizer
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1: fte = 0
  FOR B = 1 TO 59: INPUT #1, thing$(B): IF thing$(B) = olist$ THEN thing$(B) = nlist$: fte = 1
  NEXT B: CLOSE #1: IF fte = 0 THEN COLOR 4: LOCATE 11: PRINT "  LIST DOESN'T EXIST": LOCATE 12: PRINT "  FUCK YOURSELF      ": LOCATE 13: PRINT STRING$(30, " "): SLEEP 2: GOTO toporganizer
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR OUTPUT AS #1
  FOR B = 1 TO 59: WRITE #1, thing$(B): NEXT B: CLOSE #1
  NAME "C:\QBASIC\GRAFIX\" + olist$ AS "C:\QBASIC\GRAFIX\" + nlist$
  LOCATE 11: COLOR 3: PRINT " LIST "; : COLOR 2: PRINT olist$; : COLOR 3: PRINT " RENAMED": LOCATE 12: COLOR 3: PRINT " TO "; : COLOR 10: PRINT nlist$; "        ": LOCATE 13: PRINT STRING$(20, " "): SLEEP 2: GOTO toporganizer:
'rename a picture---------------------------------------------------------------------------------------------------------
ELSEIF y = 4 THEN
  LOCATE 11, 1: COLOR 8: PRINT "FILE TYPE .PIC"
  LOCATE 12, 1: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "FILE TO LOAD"
  LOCATE 13, 1: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  xx = 3: yy = 13: cc = 10: aa$ = "": IF cc <> 7 THEN cc2 = cc - 8 ELSE cc2 = 8
  DO: LOOP UNTIL INKEY$ = ""
  DO
	cf = cf + .01 + (LEN(aa$) * .0015): IF cf >= 10 THEN cf = -10
	a$ = UCASE$(INKEY$): IF LEN(a$) THEN a = ASC(a$)
	IF LEN(aa$) < 37 THEN IF (a >= 33 AND a <= 126) THEN aa$ = aa$ + a$
	IF LEN(aa$) >= 1 AND (a$ = CHR$(8) OR a$ = CHR$(0) + CHR$(83)) THEN aa$ = MID$(aa$, 1, LEN(aa$) - 1): LOCATE yy, xx + 1 + LEN(aa$): PRINT " "
	LOCATE yy, xx: COLOR cc: PRINT aa$; : COLOR cc2: IF cf > 0 THEN PRINT "Û" ELSE PRINT " "
  LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27): LOCATE yy, xx + LEN(aa$): PRINT " "
  IF a$ = CHR$(27) OR aa$ = "" THEN GOTO toporganizer:
  filetl$ = aa$
  REDIM picture(0 TO 3800), picturem(0 TO 3800), picture2(3800), picturem2(3800)
  DEF SEG = VARSEG(picture(0)): BLOAD aa$, VARPTR(picture(0))
  PUT (1, 1), picture, PSET: GET (1, 1)-(50, 50), picture2: GET (51, 1)-STEP(49, 49), picturem2
  SCREEN 7, , 0, 0: PUT (255, 60), picture2, PSET: IF editmsk <> 4 THEN PUT (255, 115), picturem2, PSET
  MouseHide
  FOR B% = 0 TO 49: FOR bb% = 0 TO 49
	LINE (B% * 5 + 1, bb% * 4 + 1)-STEP(3, 2), POINT(255 + B%, 60 + bb%), BF
  NEXT bb%: LINE (0, 0)-STEP(250, 199), 7, B: NEXT B%
  EXIT SUB
'organize a list---------------------------------------------------------------------------------------------------------
ELSEIF y = 5 THEN
  LOCATE 11, 3: COLOR 8: PRINT "Ú"; : COLOR 3: PRINT "LIST TO ORGANIZE"
  LOCATE 12, 3: COLOR 8: PRINT "Ô"; : COLOR 2: PRINT ""
  finp 5, 12, 10: list$ = aa$: IF a$ = CHR$(27) OR LEN(aa$) = 0 THEN GOTO toporganizer
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1: fte = 0
  FOR t = 1 TO 59: INPUT #1, thing$(t): IF thing$(t) = list$ THEN fte = 1
  NEXT t: CLOSE #1: IF fte = 0 THEN COLOR 4: LOCATE 11: PRINT "  LIST DOESN'T EXIST": LOCATE 12: PRINT "  FUCK YOURSELF": SLEEP 2: GOTO toporganizer
  DO: LOOP UNTIL INKEY$ = ""
  SCREEN 7, , 4, 4: CLS : LINE (10, 6)-STEP(299, 165), 3, B: LINE (9, 5)-STEP(301, 167), 10, B: LOCATE 1, 2: COLOR 8: PRINT "Ü": LOCATE 1, 39: PRINT "Ü": LINE (28, 173)-STEP(62, 12), 3, B: LINE (29, 173)-STEP(60, 11), 10, B
  LOCATE 23, 3: COLOR 8: PRINT "": LOCATE 23, 13: COLOR 8: PRINT "": LOCATE 1, 17: COLOR 5: PRINT "O"; : COLOR 13: PRINT "R"; : COLOR 13: PRINT "G"; : COLOR 15: PRINT "A"; : COLOR 15: PRINT "N";
  COLOR 13: PRINT "I"; : COLOR 13: PRINT "Z"; : COLOR 5: PRINT "E": LOCATE 22, 21 - (LEN(list$) * .5): COLOR 5: PRINT list$: LOCATE 23, 15: COLOR 8: PRINT "Press <ESC> to cancle"
 
  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR INPUT AS #1: nof = 1: lnx = 0: lny = 0
  FOR lnn = 1 TO 59
	INPUT #1, thing$(lnn): thing$(lnn) = UCASE$(thing$(lnn)): LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT thing$(lnn)
	IF LEN(thing$(lnn)) > 0 THEN lny = lny + 1: nof = nof + 1
	IF lny = 20 THEN lnx = lnx + 10: lny = 0
  NEXT lnn: CLOSE #1: thing$(nof) = "<DONE>": LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "DONE"; : COLOR 11: PRINT ">"
  yy = 1: xx = 1: nor = 3 - INT((60 - nof) / 20): gf$ = "": DO: c$ = INKEY$: LOOP UNTIL c$ = ""
 
  DO
	IF c$ = up$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy - 1
	IF c$ = dwn$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy + 1
	IF c$ = lft$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx - 1
	IF c$ = rght$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx + 1
	IF xx <= 0 THEN xx = nor ELSE IF xx > nor THEN xx = 1 ELSE IF yy > 20 THEN yy = 1
	IF c$ = dwn$ AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = 1
	IF (c$ = rght$ OR c$ = lft$) AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = nof - ((nor - 1) * 20)
	IF yy <= 0 AND xx <> nor THEN yy = 20 ELSE IF yy <= 0 AND xx = nor THEN yy = nof - ((nor - 1) * 20)
	IF gf$ = "" THEN LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 5: PRINT "Í"; : COLOR 13: PRINT ""
	IF gf$ <> "" THEN LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 4: PRINT "Ä"; : COLOR 12: PRINT "û"
	IF c$ = CHR$(32) OR c$ = CHR$(13) THEN
	  IF gf$ = "" THEN
		IF thing$((xx - 1) * 20 + yy) = "<DONE>" THEN GOTO doneorganize:
		nof = nof - 1: gf$ = thing$((xx - 1) * 20 + yy): LOCATE 23, 5 + INT((7 - LEN(a$)) * .5): COLOR 12: PRINT gf$: lny = yy - 1: lnx = (xx - 1) * 10
		FOR t = (xx - 1) * 20 + yy TO 59: thing$(t) = thing$(t + 1)
		  IF thing$(t) <> "<DONE>" THEN LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT thing$(t) + STRING$(7 - LEN(thingt$), " "):  ELSE LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "DONE"; : COLOR 11: PRINT ">"
		  IF LEN(thing$(t)) > 0 THEN lny = lny + 1: IF lny = 20 THEN lnx = lnx + 10: lny = 0
		  IF thing$(t) = "<DONE>" THEN EXIT FOR
		NEXT t: LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT "       "
	  ELSEIF gf$ <> "" THEN
		lny2 = 20: lnx2 = 20: nof = nof + 1
		FOR t = 60 TO (xx - 1) * 20 + yy STEP -1
		  thing$(t) = thing$(t - 1): IF t = (xx - 1) * 20 + yy THEN thing$(t) = gf$: gf$ = ""
		  IF thing$(t) <> "<DONE>" THEN LOCATE 1 + lny2, 5 + lnx2: COLOR 3: PRINT thing$(t) + STRING$(7 - LEN(thingt$), " ") ELSE LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "DONE"; : COLOR 11: PRINT "> "
		  lny2 = lny2 - 1: IF lny2 <= 0 AND t <> 1 THEN lnx2 = lnx2 - 10: lny2 = 20
		NEXT t: LOCATE 23, 5: PRINT "       ": gf$ = ""
	  END IF
	END IF
  c$ = INKEY$: LOOP UNTIL c$ = CHR$(27)
  IF c$ = CHR$(27) THEN GOTO toporganizer
doneorganize:
  OPEN "c:\qbasic\grafix\" + list$ + ".kyx" FOR OUTPUT AS #1
  FOR t = 1 TO 59: IF thing$(t) = "<DONE>" THEN thing$(t) = ""
  WRITE #1, thing$(t): NEXT t: CLOSE #1: GOTO toporganizer
'view lists------------------------------------------------------------------------------------------------------------------------
ELSEIF y = 6 THEN
  SCREEN 7, , 4, 4: CLS : LINE (10, 6)-STEP(299, 165), 5, B: LINE (9, 5)-STEP(301, 167), 13, B: LOCATE 1, 2: COLOR 1: PRINT "Ü": LOCATE 1, 39: PRINT "Ü": LOCATE 23, 5: COLOR 8: PRINT "PRESS A KEY"
  LOCATE 1, 14: COLOR 1: PRINT "P"; : COLOR 1: PRINT "I"; : COLOR 9: PRINT "C"; : COLOR 9: PRINT "T"; : COLOR 3: PRINT "U"; : COLOR 11: PRINT "R"; : COLOR 11: PRINT "E"; : COLOR 3: PRINT " L"; : COLOR 9: PRINT "I";
  COLOR 9: PRINT "S"; : COLOR 1: PRINT "T"; : COLOR 1: PRINT "S"
  OPEN "C:\QBASIC\GRAFIX\GLISTS.KYX" FOR INPUT AS #1: nof = 1: lnx = 0: lny = 0
	FOR lnn = 1 TO 59
	  INPUT #1, thing$(lnn): thing$(lnn) = UCASE$(thing$(lnn)): LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT thing$(lnn)
	  IF LEN(thing$(lnn)) > 0 THEN lny = lny + 1: nof = nof + 1
	  IF lny = 20 THEN lnx = lnx + 10: lny = 0
	NEXT lnn
  CLOSE #1
  DO: LOOP UNTIL INKEY$ = "": DO: LOOP UNTIL INKEY$ <> ""
  GOTO toporganizer:
ELSEIF y = 7 THEN
  REDIM picture(0 TO 3800), picturem(0 TO 3800), picture2(3800), picturem2(3800)
  SCREEN 7, , 6, 4: CLS : LINE (10, 25)-STEP(301, 151), 5, B: LINE (9, 24)-STEP(303, 153), 1, B
  LOCATE 1, 16: COLOR 8: PRINT "B"; : COLOR 4: PRINT "I"; : COLOR 12: PRINT "G"; : COLOR 14: PRINT " P"; : COLOR 15: PRINT "I"; : COLOR 15: PRINT "C"; : COLOR 14: PRINT "T"; : COLOR 12: PRINT "U"; : COLOR 4: PRINT "R"; : COLOR 8: PRINT "E": PCOPY 6 _
, 4
changelist:
  SCREEN 7, , 4, 4: LOCATE 2, 18: COLOR 2: PRINT "-"; : COLOR 10: PRINT "LIST"; : COLOR 2: PRINT "-": LOCATE 3, 18: PRINT "       ": finp 18, 3, 10
  LOCATE 2, 10: COLOR 8: PRINT "-L TO CHANGE LIST-"
  SCREEN 7, , 6, 4: LOCATE 3, 18: COLOR 8: PRINT aa$
  cx = 1: cy = 1: REDIM shit(6, 4): SCREEN 7, , 5, 4: DO: a$ = INKEY$: LOOP UNTIL a$ = "":
  DO: PCOPY 6, 5: LINE ((cx - 1) * 50 + 11, (cy - 1) * 50 + 26)-STEP(49, 49), 10, B
	IF a$ = up$ THEN cy = cy - 1: IF cy <= 0 THEN cy = 3
	IF a$ = dwn$ THEN cy = cy + 1: IF cy >= 4 THEN cy = 1
	IF a$ = lft$ THEN cx = cx - 1: IF cx <= 0 THEN cx = 6
	IF a$ = rght$ THEN cx = cx + 1: IF cx >= 7 THEN cx = 1
	IF a$ = " " THEN SCREEN 7, , 4, 4: load 0: SCREEN 7, , 6, 4: PUT ((cx - 1) * 50 + 11, (cy - 1) * 50 + 26), picture2, PSET: SCREEN 7, , 5, 4
	IF a$ = "L" THEN GOTO changelist
  PCOPY 5, 4: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = CHR$(27)
  GOTO toporganizer:
END IF

SCREEN 7, , 0, 0
END SUB

SUB save
REDIM picture2(3800)
REDIM picturem2(3800)
MouseHide
FOR B% = 0 TO 49: FOR bb% = 0 TO 49: PSET (255 + B%, 60 + bb%), POINT(B% * 5 + 2, bb% * 4 + 2): NEXT bb%: NEXT B%
IF editmsk <> 4 THEN
  FOR B% = 0 TO 49: FOR bb% = 0 TO 49: cococ = 0
  IF POINT(B% * 5 + 2, bb% * 4 + 2) = 0 THEN cococ = 15
  PSET (255 + B%, 115 + bb%), cococ: NEXT bb%: NEXT B%
END IF
GET (255, 60)-STEP(49, 49), picture2
GET (255, 115)-STEP(49, 49), picturem2
LINE (252, 167)-STEP(80, 50), 0, BF:

LOCATE 22, 33: COLOR 2: PRINT "-"; : COLOR 10: PRINT "LIST"; : COLOR 2: PRINT "-"
finp 33, 23, 10
IF LEN(aa$) THEN list$ = LTRIM$(RTRIM$(aa$))
IF LEN(list$) = 0 OR a$ = CHR$(27) THEN EXIT SUB

	  SCREEN 7, , 3, 3: CLS
	  LINE (10, 6)-STEP(299, 165), 1, B
	  LINE (9, 5)-STEP(301, 167), 5, B
	  LOCATE 1, 2: COLOR 1: PRINT "Ü"
	  LOCATE 1, 39: COLOR 1: PRINT "Ü"
	  LOCATE 1, 16: COLOR 4:  PRINT "S": LOCATE 1, 17: COLOR 12: PRINT "A"
	  LOCATE 1, 18: COLOR 14: PRINT "V": LOCATE 1, 19: COLOR 15: PRINT "E"
	  LOCATE 1, 21: COLOR 15: PRINT "F": LOCATE 1, 22: COLOR 14: PRINT "I"
	  LOCATE 1, 23: COLOR 12: PRINT "L": LOCATE 1, 24: COLOR 4:  PRINT "E"
	 
	  LOCATE 23, 5: COLOR 8: PRINT "LAST LOADED: "; name$
	  COLOR 8: FOR t = 1 TO LEN(list$): LOCATE 1 + t, 38: PRINT MID$(list$, t, 1): NEXT t
	  REDIM gfxfile$(61)
	  OPEN "C:\QBASIC\GRAFIX\" + list$ + ".KYX" FOR INPUT AS #1: nof = 2: lnx = 0: lny = 0
	  FOR lnn = 1 TO 59
		INPUT #1, gfxfile$(lnn): gfxfile$(lnn) = UCASE$(gfxfile$(lnn))
		LOCATE 2 + lny, 5 + lnx: COLOR 3: PRINT gfxfile$(lnn)
		IF LEN(gfxfile$(lnn)) > 0 THEN lny = lny + 1: nof = nof + 1
		IF lny = 20 THEN lnx = lnx + 10: lny = 0
	  NEXT lnn: CLOSE #1: lny = lny + 1: IF lny = 20 THEN lnx = lnx + 10: lny = 0
	  gfxfile$(nof) = "<CANCLE>": IF nof <= 60 THEN LOCATE 2 + lny, 5 + lnx: COLOR 11: PRINT "<"; : COLOR 3: PRINT "CANCLE"; : COLOR 11: PRINT ">"
	  nor = 3 - INT((60 - nof) / 20): nor2 = 3 - INT((61 - nof) / 20)
	  yy = nof - ((nor2 - 1) * 20) - 1: xx = 3 - INT((61 - nof) / 20): aa$ = ""
	  IF nof > 60 THEN
		LOCATE 22, 1: PRINT STRING$(40, " "): LOCATE 21, 25: COLOR 3: PRINT "<CANCLE>": LOCATE 22, 1: COLOR 5: PRINT STRING$(40, "Í")
		cf2 = 0: cf = 0: DO: cf = cf + 1: cf2 = cf2 + 1
		  IF cf2 < 200 THEN
			LOCATE 22, 14: COLOR 13: PRINT " "; : COLOR 4: PRINT "L"; : COLOR 12: PRINT "I"; : COLOR 14: PRINT "S"; : COLOR 15: PRINT "T ";
			COLOR 15: PRINT "F"; : COLOR 14: PRINT "U"; : COLOR 12: PRINT "L"; : COLOR 4: PRINT "L"; : COLOR 13: PRINT " "
		  ELSE
			LOCATE 22, 15: PRINT "           ": IF cf2 > 400 THEN cf2 = 0
		  END IF
		LOOP UNTIL INKEY$ <> "" OR cf >= 3000: GOTO donesaving:
	  END IF
	  DO
		IF c$ = up$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy - 1
		IF c$ = dwn$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = yy + 1
		IF c$ = lft$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx - 1
		IF c$ = rght$ THEN : LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": xx = xx + 1
		IF xx <= 0 THEN xx = nor ELSE IF xx > nor THEN xx = 1 ELSE IF yy > 20 THEN yy = 1
		IF c$ = dwn$ AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = 1
		IF (c$ = rght$ OR c$ = lft$) AND (xx = nor AND yy > nof - ((nor - 1) * 20)) THEN yy = nof - ((nor - 1) * 20)
		IF yy <= 0 AND xx <> nor THEN yy = 20 ELSE IF yy <= 0 AND xx = nor THEN yy = nof - ((nor - 1) * 20)
		LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 2: PRINT "Í"; : COLOR 10: PRINT ""
		IF yy = nof - ((nor2 - 1) * 20) - 1 AND xx = 3 - INT((61 - nof) / 20) THEN
		  cf = cf + .01 + (LEN(aa$) * .0009): IF cf >= 10 THEN cf = -10
		  c$ = UCASE$(c$): IF LEN(c$) THEN a = ASC(c$)
		  IF LEN(aa$) < 7 THEN IF (a >= 48 AND a <= 57) OR (a >= 65 AND a <= 90) OR (a >= 97 AND a <= 122) OR a = 95 THEN aa$ = aa$ + c$
		  IF LEN(aa$) >= 1 AND (c$ = CHR$(8) OR c$ = CHR$(0) + CHR$(83)) THEN aa$ = MID$(aa$, 1, LEN(aa$) - 1): LOCATE nof - ((nor2 - 1) * 20), 6 + ((3 - INT((61 - nof) / 20)) - 1) * 10 + LEN(aa$): PRINT " "
		  LOCATE nof - ((nor2 - 1) * 20), 5 + ((3 - INT((61 - nof) / 20)) - 1) * 10: COLOR 2: PRINT aa$;
		  COLOR 2: IF cf > 0 THEN PRINT "Û" ELSE PRINT " "
		ELSE
		  LOCATE nof - ((nor2 - 1) * 20), 5 + ((3 - INT((61 - nof) / 20)) - 1) * 10: PRINT "        "
		END IF
	  c$ = INKEY$: LOOP UNTIL c$ = " " OR c$ = CHR$(13) OR c$ = CHR$(27): name$ = gfxfile$((xx - 1) * 20 + yy)
	  IF c$ = CHR$(27) OR name$ = "<CANCLE>" OR (aa$ = "" AND name$ = "") THEN GOTO donesaving:
	  IF yy = nof - ((nor2 - 1) * 20) - 1 AND xx = 3 - INT((61 - nof) / 20) THEN
		FOR t = 1 TO 59
		  IF aa$ = gfxfile$(t) AND LEN(gfxfile$(t)) > 0 THEN
			name$ = gfxfile$(t): gfxfile$(yy + ((xx - 1) * 20)) = "": LOCATE yy + 1, 3 + (xx - 1) * 10: PRINT "  ": yy = t - INT(t / 20) * 20: xx = INT((t - 1) / 20) + 1
			LOCATE yy + 1, 3 + (xx - 1) * 10: COLOR 2: PRINT "Í"; : COLOR 10: PRINT "": aa$ = "": GOTO overwrite:
		  END IF
		NEXT t: gfxfile$(yy + ((xx - 1) * 20)) = aa$: name$ = aa$
	  ELSE
		name$ = gfxfile$(yy + ((xx - 1) * 20))
overwrite:
		LOCATE 23, 2: COLOR 3: PRINT STRING$(38, "ù")
		LOCATE 23, 13: COLOR 10: PRINT "OVERWRITE "; : COLOR 2: PRINT "("; : COLOR 10: PRINT "Y"; : COLOR 2: PRINT "/"; : COLOR 10: PRINT "N"; : COLOR 2: PRINT ")"
		DO: a$ = UCASE$(INKEY$): LOOP UNTIL a$ = CHR$(13) OR a$ = CHR$(27) OR a$ = "Y" OR a$ = "N"
		IF a$ = "N" OR a$ = CHR$(27) THEN GOTO donesaving:
	  END IF
	  OPEN "c:\qbasic\grafix\" + list$ + ".kyx" FOR OUTPUT AS #1
	  FOR t = 1 TO 59: IF gfxfile$(t) = "<CANCLE>" THEN gfxfile$(t) = ""
	  WRITE #1, gfxfile$(t): NEXT t: CLOSE #1
	  ERASE gfxfile$
SCREEN 7, , 3, 3
CLS
PUT (1, 1), picture2, PSET
PUT (51, 1), picturem2, PSET
GET (1, 1)-STEP(101, 49), picture2
DEF SEG = VARSEG(picture2(0))
BSAVE "C:\QBASIC\GRAFIX\" + list$ + "\" + name$ + ".PIC", VARPTR(picture2(0)), 7000
ERASE picturem2
donesaving:
SCREEN 7, , 0, 0
END SUB

SUB test
REDIM picture(3800)
SCREEN 7, , 1, 0
DEF SEG = VARSEG(picture(0))
BLOAD "walkr1.PIC", VARPTR(picture(0))
PUT (50, 50), picture

SCREEN 7, , 2, 0
DEF SEG = VARSEG(picture(0))
BLOAD "walkr2.PIC", VARPTR(picture(0))
PUT (50, 50), picture

SCREEN 7, , 3, 0
DEF SEG = VARSEG(picture(0))
BLOAD "walkr3.PIC", VARPTR(picture(0))
PUT (50, 50), picture
SCREEN 7, , 0, 0
DO
PCOPY 1, 0: FOR B = 1 TO 1200: NEXT B
PCOPY 2, 0: FOR B = 1 TO 1200: NEXT B
PCOPY 3, 0: FOR B = 1 TO 1200: NEXT B
PCOPY 2, 0: FOR B = 1 TO 1200: NEXT B
LOOP

END SUB

SUB wkey
DO: a$ = INKEY$: LOOP UNTIL a$ = ""


END SUB

