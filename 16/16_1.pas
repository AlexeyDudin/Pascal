PROGRAM SortingMonth(INPUT, OUTPTUT);
USES DateIO;

PROCEDURE CheckMonthFromInput;
VAR
  Month1, Month2: Month;
BEGIN
  ReadMonth(INPUT, Month1);
  ReadMonth(INPUT, Month2);

  IF ((Month1 = NoMonth) OR (Month2 = NoMonth))
  THEN
    WRITELN('�室�� ����� ����ᠭ� ����୮')
  ELSE
    IF (Month1 < Month2)
    THEN
      BEGIN
        WriteMonth(OUTPUT, Month1);
        WRITE(OUTPUT, ' �।����� ');
	WriteMonth(OUTPUT, Month2)
      END
    ELSE
      IF (Month1 > Month2)
      THEN
        BEGIN
          WriteMonth(OUTPUT, Month1);
          WRITE(' ᫥��� �� ');
	  WriteMonth(OUTPUT, Month2)
        END
      ELSE
        BEGIN
          WRITE('��� ����� ');
          WriteMonth(OUTPUT, Month1)
	END
END;

BEGIN
  CheckMonthFromInput;
  WRITELN
END.
