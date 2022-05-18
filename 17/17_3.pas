PROGRAM Stat(INPUT, OUTPUT);
VAR
  IsEnd: BOOLEAN;
  Dig: INTEGER;
  Result: INTEGER;
  Min, Max, Mid: INTEGER;
  Ost : INTEGER;
  CountDigits: INTEGER;


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
  IF (Ch = ' ') THEN Digit := -2 ELSE
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

PROCEDURE ReadNumber(VAR F: TEXT; VAR Digit: INTEGER);
VAR
  CurrDigit: INTEGER;
  IsEnd: BOOLEAN;
BEGIN
  IsEnd := FALSE;
  Digit := 0;
  WHILE (NOT EOLN(F)) AND (NOT IsEnd)
  DO
    BEGIN
      ReadDigit(F, CurrDigit);
      IF (CurrDigit = -2)
      THEN
        BEGIN
          IsEnd := TRUE;
        END
      ELSE
        IF (CurrDigit >= 0)
        THEN
          BEGIN
            Digit := Digit*10 + CurrDigit;
          END;
    END
END;

BEGIN
  IsEnd := FALSE;
  Dig := 0;
  Result := 0;
  Min := MAXINT;
  Max := -MAXINT;
  WRITELN(MAXINT);
  CountDigits := 0;
  WHILE (NOT EOLN)
  DO
    BEGIN
      ReadNumber(INPUT, Dig);
      IF (Dig >= 0)
      THEN
        BEGIN
          CountDigits := CountDigits + 1;
          IF (Dig < Min)
          THEN
            Min := Dig;
         IF (Dig > Max)
         THEN
            Max := Dig;

         IF (Mid <> 0)
         THEN
           Mid := (Mid + Dig)
         ELSE
           Mid := Dig
        END
      ELSE
        BEGIN
        END
    END;
  
  WRITELN('Minimum is ', Min:2);
  WRITELN('Maximum is ', Max:2);
  IF (((Mid MOD CountDigits) * 100) DIV CountDigits) < 10
  THEN
    WRITELN('Middle is ', Mid DIV CountDigits:3, '.0', ((Mid MOD CountDigits) * 100) DIV CountDigits)
  ELSE
    WRITELN('Middle is ', Mid DIV CountDigits:3, '.', ((Mid MOD CountDigits) * 100) DIV CountDigits)
END.
