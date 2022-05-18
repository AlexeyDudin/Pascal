UNIT LtrSet;

INTERFACE
CONST
  MAXELEM = 25;

TYPE
  LetterSet = SET OF 1 .. MAXELEM;

PROCEDURE PrintLetterSet(Letter: LetterSet);
FUNCTION Letter2Set(Ch: CHAR): LetterSet;

IMPLEMENTATION
CONST
  ASet = [3, 7, 9, 12, 14, 17, 18, 19, 21, 25];
  MSet = [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
  TSet = [1, 2, 3, 4, 5, 8, 13, 18, 23];
  NSet = [1, 6, 11, 16, 21, 5, 10, 15, 20, 25, 7, 13, 19];
  NoLetter = [1 .. 25];

FUNCTION Letter2Set(Ch: CHAR): LetterSet;
BEGIN
  CASE Ch OF
    'A': Letter2Set := ASet;
    'T': Letter2Set := TSet;
    'M': Letter2Set := MSet;
    'N': Letter2Set := NSet
  ELSE
    Letter2Set := NoLetter
  END;
END;

PROCEDURE PrintLetterSet(Letter: LetterSet);
VAR
  I: BYTE;
BEGIN
  FOR I := 1 TO MAXELEM
  DO
    BEGIN
      IF (I IN Letter)
      THEN
        WRITE('#')
      ELSE
        WRITE(' ');
      IF ((I MOD 5) = 0)
      THEN
        WRITELN
    END
END;

BEGIN
END.