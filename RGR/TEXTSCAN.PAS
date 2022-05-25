UNIT TextScan;

INTERFACE

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);

IMPLEMENTATION
USES StWorker, VAR_TYPE, States, Tree;

VAR
  State: StatesType;
  LastReadedChar: CHAR;

PROCEDURE InitializeVariables(VAR LastReadedChar: CHAR);
BEGIN
  LastReadedChar := StartChar; {//TODO }
  SetStateToStart;
END;

PROCEDURE SkipSpaces(VAR InputFile: TEXT; VAR LastReadedChar: CHAR);
BEGIN
  WHILE (NOT EOF(InputFile)) AND (NOT IsStateWord)
  DO
    BEGIN
      READ(InputFile, LastReadedChar);
      LastReadedChar := TryChangeChar(LastReadedChar);
      IF CharCompatible(LastReadedChar)
      THEN
        SetStateToWord
    END
END;

FUNCTION FindWord(VAR InputFile: TEXT; VAR LastReadedChar: CHAR): MyString;
VAR
  Result: MyString;
BEGIN
  IF (CharCompatible(LastReadedChar))
  THEN
    Result := LastReadedChar
  ELSE
    Result := '';
  WHILE (NOT EOF(InputFile)) AND (IsStateWord)
  DO
    BEGIN
      READ(InputFile, LastReadedChar);
      LastReadedChar := TryChangeChar(LastReadedChar);
      IF (NOT CharCompatible(LastReadedChar))
      THEN
        SetStateToSpace;
      IF (IsStateWord)
      THEN
        Result := Result + LastReadedChar
    END;
  FindWord := Result
END;

PROCEDURE HandleWord(RecievedWord: MyString);
BEGIN
  IF (RecievedWord <> '')
  THEN
    AddWordInStorage(RecievedWord)
END;

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile: TEXT);
VAR
  RecievedWord: MyString;
BEGIN
  InitializeVariables(LastReadedChar);
  REPEAT
    SkipSpaces(InputFile, LastReadedChar);
    RecievedWord := FindWord(InputFile, LastReadedChar);
    HandleWord(RecievedWord)
  UNTIL EOF(InputFile);
  PrintStorage(OutputFile)
END;

BEGIN

END.
