UNIT StWorker;

INTERFACE
USES VarType;

FUNCTION CharCompatible(Ch: CHAR): BOOLEAN;
FUNCTION ToLowerCase(Ch: CHAR): CHAR;
FUNCTION IsFirstLowerSecond(First, Second: MyString): BOOLEAN;
FUNCTION GetWord(VAR InputFile: TEXT): MyString;

IMPLEMENTATION

USES States;

PROCEDURE SkipSpaces(VAR InputFile: TEXT; VAR LastReadedChar: CHAR);
BEGIN
  WHILE (NOT EOF(InputFile)) AND (NOT IsStateWord)
  DO
    BEGIN
      READ(InputFile, LastReadedChar);
      LastReadedChar := ToLowerCase(LastReadedChar);
      IF CharCompatible(LastReadedChar)
      THEN
        SetStateToWord
    END
END;

FUNCTION IsFirstCharDash(CurrentWord: MyString): BOOLEAN;
BEGIN
  IsFirstCharDash := (CurrentWord[1] = '-')
END;

FUNCTION IsLastCharDash(CurrentWord: MyString): BOOLEAN;
BEGIN
  IsLastCharDash := (CurrentWord[LENGTH(CurrentWord)] = '-')
END;

FUNCTION IsWordCorrect(CurrentWord: MyString): BOOLEAN;
BEGIN
  IF NOT (IsFirstCharDash(CurrentWord))
  THEN
    IF NOT IsLastCharDash(CurrentWord)
    THEN
      IsWordCorrect := TRUE
    ELSE
      IsWordCorrect := FALSE
  ELSE
    IsWordCorrect := FALSE
END;

FUNCTION GetWord(VAR InputFile: TEXT): MyString;
VAR
  Res: MyString;
  LastReadedChar: CHAR;
BEGIN
  SkipSpaces(InputFile, LastReadedChar);
  IF (CharCompatible(LastReadedChar))
  THEN
    Res := LastReadedChar
  ELSE
    Res := '';
  WHILE (NOT EOF(InputFile)) AND (IsStateWord)
  DO
    BEGIN
      READ(InputFile, LastReadedChar);
      LastReadedChar := ToLowerCase(LastReadedChar);
      IF (NOT CharCompatible(LastReadedChar))
      THEN
        SetStateToSpace;
      IF (IsStateWord)
      THEN
        Res := Res + LastReadedChar
    END;
  IF NOT IsWordCorrect(Res)
  THEN
    Res := '';
  GetWord := Res
END;

FUNCTION CharCompatible(Ch: CHAR): BOOLEAN;
VAR
  I: INTEGER;
  IsFound: BOOLEAN;
BEGIN
  IsFound := FALSE;
  I := 1;
  WHILE (I <= LENGTH(CompatibleChars)) AND (NOT IsFound)
  DO
    BEGIN
      IF (Ch = CompatibleChars[I])
      THEN
          IsFound := TRUE;
      I := I + 1
    END;
  CharCompatible := IsFound
END;

FUNCTION ToLowerCase(Ch: CHAR): CHAR;
VAR
  I: INTEGER;
  IsFindChar: BOOLEAN;
BEGIN
  ToLowerCase := Ch;
  IF (Ch = AdditionChar1) OR (Ch = AdditionChar2)
  THEN
    ToLowerCase := '¥'
  ELSE
    BEGIN
      I := 1;
      IsFindChar := FALSE;
      WHILE (I <= LENGTH(UpperChars)) AND (NOT IsFindChar)
      DO
        BEGIN
          IF (Ch = UpperChars[I])
          THEN
            BEGIN
              ToLowerCase := CompatibleChars[I];
              IsFindChar := TRUE
            END;
          I := I + 1
        END
    END
END;

FUNCTION IsFirstLowerSecond(First, Second: MyString): BOOLEAN;
VAR
  I: INTEGER;
  IsFound: BOOLEAN;
BEGIN
  IsFound := FALSE;
  IsFirstLowerSecond := TRUE;
  I := 1;
  WHILE (I <= LENGTH(First)) AND (NOT IsFound)
  DO
    BEGIN
      IF I > LENGTH(Second)
      THEN
        BEGIN
          IsFirstLowerSecond := FALSE;
          IsFound := TRUE
        END;
      IF First[I] < Second[I]
      THEN
        IsFound := TRUE;
      IF First[I] > Second[I]
      THEN
        BEGIN
          IsFirstLowerSecond := FALSE;
          IsFound := TRUE
        END;
      I := I + 1
    END
END;

BEGIN
  SetStateToStart;
END.
