UNIT SymbCtrl;

INTERFACE
CONST
  MaxElem = 25;

TYPE
  LetterSet = SET OF 1 .. MaxElem;

TYPE
  ChArray = ARRAY [A .. Z] OF CHAR;

PROCEDURE ReadLetters(str: ChArray);
PROCEDURE PrintLetters;

IMPLEMENTATION
VAR
  LetterArr: ARRAY [1 .. 10] OF LetterSet;

PROCEDURE ReadLetters(str: ChArray);
VAR
  F: TEXT;
  Ch: CHAR;
  IntLtr: INTEGER;
  LtrSet: LEtterArr;
BEGIN
  ASSIGN(F, 'Letters.txt');

  FOR I := 0 TO LENGTH(str)
  DO
  BEGIN
    RESET(F);

    WHILE NOT EOF(F)
    DO
      BEGIN
        READ(F, Ch);
        IF (Ch = str[i])
        THEN
          BEGIN
            WHILE NOT EOLN(F)
            DO
              BEGIN
                READ(F, IntLtr);
                LtrSet := LtrSet + [IntLtr];
              END
            LetterArr[I] := LtrSet;
          END
        ELSE
          READLN(F);
      END

  END;
  CLOSE(F)
END;

BEGIN
END.