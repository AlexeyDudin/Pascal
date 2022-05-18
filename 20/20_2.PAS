PROGRAM T20(INPUT, OUTPUT);
USES LTRARR;
VAR
  Str: ChArr;
  Ch: CHAR;
  I: BYTE;

PROCEDURE FillAllStr(VAR I: BYTE; VAR Str: ChArr);
BEGIN
  WHILE (I <= MaxChars)
  DO
    BEGIN
      Str[I] := InvalidSymbol;
      I := I + 1
    END
END;

PROCEDURE ReadSymbols(VAR I: BYTE; VAR Str: ChArr);
BEGIN
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      IF (I > MaxChars)
      THEN
        BREAK;

      READ(INPUT, Ch);
      Str[I] := Ch;
      I := I + 1
    END
END;

BEGIN
  I := 1;

  WRITE('Введите символы: ');
  ReadSymbols(I, Str);

  WRITELN;

  FillAllStr(I, Str);
  FillAllLetterArray(Str);

  WriteAllLetter
END.