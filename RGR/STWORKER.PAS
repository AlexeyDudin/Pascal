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
  I := 1;
  WHILE (I <= LENGTH(CompatibleChars)) AND (NOT CharCompatible)
  DO
    BEGIN
      IF (Ch = CompatibleChars[I])
      THEN
          CharCompatible := TRUE;
      I := I + 1
    END
END;

FUNCTION TryChangeChar(Ch: CHAR): CHAR;
VAR
  I: INTEGER;
  IsFindChar: BOOLEAN;
BEGIN
  TryChangeChar := Ch;
  IF (Ch = AdditionChar1) OR (Ch = AdditionChar2)
  THEN
    TryChangeChar := '¥'
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
              TryChangeChar := CompatibleChars[I];
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
END.
