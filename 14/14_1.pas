PROGRAM ReverseProgram(INPUT, OUTPUT);

PROCEDURE Reverse(VAR F1: TEXT; VAR F2: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      Reverse(F1, F2);
      WRITE(F2, Ch)
    END
END;

BEGIN
  Reverse(INPUT, OUTPUT);
  WRITELN
END.
