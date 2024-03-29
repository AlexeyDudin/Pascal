PROGRAM TestReadDigit(INPUT, OUTPUT);

VAR
  Sum, Dig: INTEGER;
  IsEnd: BOOLEAN;

PROCEDURE CharToDigit(VAR Ch: CHAR; VAR Digit: INTEGER);
BEGIN
  IF (Ch = '0') THEN Digit := 0 ELSE
  IF (Ch = '1') THEN Digit := 1 ELSE
  IF (Ch = '2') THEN Digit := 2 ELSE
  IF (Ch = '3') THEN Digit := 3 ELSE
  IF (Ch = '4') THEN Digit := 4 ELSE
  IF (Ch = '5') THEN Digit := 5 ELSE
  IF (Ch = '6') THEN Digit := 6 ELSE
  IF (Ch = '7') THEN Digit := 7 ELSE
  IF (Ch = '8') THEN Digit := 8 ELSE
  IF (Ch = '9') THEN Digit := 9 ELSE
  Digit := -1
END;

PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
  TempDigit: INTEGER;
BEGIN
  D := 0;
  READ(Ch);
  CharToDigit(Ch, D);
END;

BEGIN
  Dig := 0;
  Sum := 0;
  IsEnd := FALSE;

  WHILE (NOT EOLN) AND (NOT IsEnd)
  DO
    BEGIN
      ReadDigit(INPUT, Dig);
      IF Dig >= 0
      THEN
        Sum := Sum + Dig
      ELSE
        IsEnd := TRUE
    END;
  IF Sum = 0
  THEN
    Sum := -1;
  WRITELN(Sum:3)
END.