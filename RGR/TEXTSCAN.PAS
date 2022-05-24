UNIT TextScan;

INTERFACE

PROCEDURE RunScanText(VAR InputFile, OutputFile: TEXT);

IMPLEMENTATION
USES StWorker, VAR_TYPE, States, Tree;

VAR
  State: StatesType;
  LastReadedChar: CHAR;

PROCEDURE InitializeVariables;
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

PROCEDURE RunScanText(VAR InputFile, OutputFile: TEXT);
VAR
  ReturnedWord: MyString;
BEGIN
  InitializeVariables;
  REPEAT
    SkipSpaces(InputFile, LastReadedChar);
    ReturnedWord := FindWord(InputFile, LastReadedChar);
    IF (ReturnedWord <> '')
    THEN
      AddWordInTree(ReturnedWord)
  UNTIL EOF(InputFile);
  PrintTree(OutputFile)
END;

BEGIN

END.
