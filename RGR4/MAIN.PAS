PROGRAM GroupWords(INPUT, OUTPUT);
USES Analizer;
VAR
  F: TEXT;

BEGIN
  ASSIGN(F, '11.txt');
  RESET(F);
  CountNumberOfWordsFrom(F, OUTPUT)
END.
