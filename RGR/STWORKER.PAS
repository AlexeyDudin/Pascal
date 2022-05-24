UNIT StWorker;

INTERFACE
USES Var_Type;

FUNCTION CharCompatible(Ch: CHAR): BOOLEAN;
FUNCTION TryChangeChar(Ch: CHAR): CHAR;
FUNCTION IsFirstLowerSecond(First, Second: MyString): BOOLEAN;

IMPLEMENTATION

FUNCTION CharCompatible(Ch: CHAR): BOOLEAN;
VAR
  I: INTEGER;
BEGIN
  CharCompatible := FALSE;
  FOR I := 1 TO LENGTH(CompatibleChars)
  DO
    IF (Ch = CompatibleChars[I])
    THEN
      BEGIN
        CharCompatible := TRUE;
        BREAK
      END
END;

FUNCTION TryChangeChar(Ch: CHAR): CHAR;
VAR
  I: INTEGER;
BEGIN
  TryChangeChar := Ch;
  IF (Ch = AdditionChar1) OR (Ch = AdditionChar2)
  THEN
    TryChangeChar := '¥'
  ELSE
    FOR I := 1 TO LENGTH(UpperChars)
    DO
      IF (Ch = UpperChars[I])
      THEN
        BEGIN
          TryChangeChar := CompatibleChars[I];
          BREAK
        END
END;

FUNCTION IsFirstLowerSecond(First, Second: MyString): BOOLEAN;
VAR
  I, J: INTEGER;
BEGIN
  IsFirstLowerSecond := TRUE;
  FOR I := 1 TO LENGTH(First)
  DO
    BEGIN
      IF I > LENGTH(Second)
      THEN
        BEGIN
          IsFirstLowerSecond := FALSE;
          BREAK
        END;
      IF First[I] < Second[I]
      THEN
        BEGIN
          BREAK
        END;
      IF First[I] > Second[I]
      THEN
        BEGIN
          IsFirstLowerSecond := FALSE;
          BREAK;
        END
    END
END;

BEGIN
END.