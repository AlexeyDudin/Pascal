UNIT TextScan;

INTERFACE

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);

IMPLEMENTATION
USES StWorker, VarType, Tree;

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);
VAR
  RecievedWord: MyString;
BEGIN
  REPEAT
    RecievedWord := GetWord(InputFile);
    IF (RecievedWord <> '')
    THEN
      AddWordInStorage(RecievedWord)
  UNTIL EOF(InputFile);
  AddResidueTreeInFile;
  PrintStorage(OutputFile)
END;

BEGIN
END.
