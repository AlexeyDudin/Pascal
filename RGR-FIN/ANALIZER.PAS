UNIT Analizer;

INTERFACE
PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);

IMPLEMENTATION
USES VarType, StWorker, Storage;

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);
VAR
  ReadedWord: MyString;
  ReadedCount: INTEGER;
  RootOfReadedWord: MyString;
BEGIN
  REPEAT
    ReadedWord := GetWord(InputFile);
    READLN(InputFile, ReadedCount);
    RootOfReadedWord := GetWordRoot(ReadedWord);
    IF (RootOfReadedWord <> '')
    THEN
      AddInStorage(RootOfReadedWord, ReadedWord, ReadedCount)
  UNTIL EOF(InputFile);
  PrintStorage(OutputFile);
END;

BEGIN
END.
