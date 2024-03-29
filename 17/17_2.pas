PROGRAM ReadNumber(INPUT, OUTPUT);
VAR
  IsEnd: BOOLEAN;
  Dig: INTEGER;
  Result: INTEGER;

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
  IsEnd := FALSE;
  Dig := 0;
  Result := 0;
  WRITELN(MAXINT);

  WHILE (NOT EOLN) AND (NOT IsEnd)
  DO
    BEGIN
      ReadDigit(INPUT, Dig);
      IF (Dig >= 0)
      THEN
        BEGIN
          IF ((MAXINT - Dig) DIV 10) >= Result
          THEN
            Result := Result * 10 + Dig
          ELSE
            BEGIN
              IsEnd := FALSE;
              Result := -2;
            END
        END
      ELSE
        BEGIN
          IsEnd := FALSE;
          Result := -1
        END;
    END;
  WRITELN(Result:5);
END.