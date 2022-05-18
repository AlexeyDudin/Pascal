PROGRAM CountReverse(INPUT, OUTPUT);

USES
  Count3;

VAR
  Ch1, Ch2, Ch3: CHAR;

BEGIN
  IF NOT EOLN(INPUT)
  THEN
    READ(INPUT, Ch2);
  IF NOT EOLN(INPUT)
  THEN
    READ(INPUT, Ch3);
  Start;

  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      Ch1 := Ch2;
      Ch2 := Ch3;
      READ(INPUT, Ch3);
      IF ((Ch1 > Ch2) AND (Ch2 < Ch3)) OR ((Ch1 < Ch2) AND (Ch2 > Ch3))
      THEN
        Bump;
    END;
  WRITELN;
  Value(Ch1, Ch2, Ch3);
  IF ((Ch1 = '9') AND (Ch2 = '9') AND (Ch3 = '9'))
  THEN
    WRITELN('Количество реверсов: 999 OR Higher')
  ELSE
    WRITELN('Количество реверсов: ', Ch1, Ch2, Ch3)
END.
