PROGRAM CheckLtrSet(INPUT, OUTPUT);

USES LtrSet;

VAR
  Ch: CHAR;

BEGIN
  WRITE('Введите букву: ');
  READ(Ch);
  PrintLetterSet(Letter2Set(Ch));
  WRITELN
END.