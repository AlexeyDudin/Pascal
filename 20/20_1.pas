PROGRAM CheckLtrSet(INPUT, OUTPUT);

USES LtrSet;

VAR
  Ch: CHAR;

BEGIN
  WRITE('������ �㪢�: ');
  READ(Ch);
  PrintLetterSet(Letter2Set(Ch));
  WRITELN
END.