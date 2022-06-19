UNIT StWorker;

INTERFACE
USES VarType;

FUNCTION CharCompatible(Ch: CHAR): BOOLEAN;
FUNCTION ToLowerCase(Ch: CHAR): CHAR;
FUNCTION IsFirstLowerSecond(First, Second: MyString): BOOLEAN;
FUNCTION GetWord(VAR InputFile: TEXT): MyString;
FUNCTION GetWordRoot(VAR AnalizedWord: MyString): MyString;

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

FUNCTION IsCharInVowels(Ch: CHAR): BOOLEAN;
VAR
  I: INTEGER;
  Res: BOOLEAN;
BEGIN
  Res := FALSE;
  FOR I := 1 To Length(Vowels)
  DO
    IF (Ch = Vowels[I])
    THEN
      Res := TRUE;
  IsCharInVowels := Res
END;

PROCEDURE SetWordAreas(VAR AnalizedWord: MyString; VAR R0, Rv, R1, R2: MyString);
VAR
  I, J: INTEGER;
  State: STRING;
BEGIN
  R0 := '';
  Rv := '';
  R1 := '';
  R2 := '';

  State := 'RV';

  FOR I := 1 TO Length(AnalizedWord)
  DO
    BEGIN
      IF ((IsCharInVowels(AnalizedWord[I])) OR (State <> 'RV') AND (State <> 'F'))
      THEN
        BEGIN
          IF State = 'RV'
          THEN
            BEGIN
              R0 := Copy(AnalizedWord, 0, i);
              Rv := Copy(AnalizedWord, i + 1, LENGTH(AnalizedWord));
              State := 'R1'
            END;
          IF State = 'R1'
          THEN
            BEGIN
              IF (I < LENGTH(AnalizedWord))
              THEN
                BEGIN
                  IF (IsCharInVowels(AnalizedWord[I]) AND (I + 1 < LENGTH(AnalizedWord)) AND (NOT IsCharInVowels(AnalizedWord[I + 1])))
                  THEN
                    BEGIN
                      R1 := Copy(AnalizedWord, I + 2, LENGTH(AnalizedWord));
                      State := 'R2'
                    END
                END
            END
          ELSE
            IF State = 'R2'
            THEN
              BEGIN
                IF (I < LENGTH(AnalizedWord))
                THEN
                  BEGIN
                    IF I < LENGTH(AnalizedWord)
                    THEN
                      IF (IsCharInVowels(AnalizedWord[I]) AND (I + 1 < LENGTH(AnalizedWord)) AND (IsCharInVowels(AnalizedWord[I + 1])))
                      THEN
                        BEGIN
                          R2 := Copy(AnalizedWord, I + 2, LENGTH(AnalizedWord));
                          State := 'F'
                        END
                  END
              END
        END
    END
END;

FUNCTION IsEndOn(Rv, Ending: MyString):BOOLEAN;
VAR
  Res: BOOLEAN;
  Tmp: MyString;
BEGIN
  Res := FALSE;
  IF (LENGTH(Ending) <= LENGTH(Rv))
  THEN
    BEGIN
      Tmp := COPY(RV, LENGTH(Rv) - LENGTH(Ending) + 1, LENGTH(Rv));
      IF (Tmp = Ending)
      THEN
        Res := TRUE;
    END;

  IsEndOn := Res;
END;

PROCEDURE DeleteEnding(VAR Rv, Ending: MyString);
BEGIN
  Rv := COPY(Rv, 1, LENGTH(Rv) - LENGTH(Ending))
END;

FUNCTION DeletePerfectiveGerund(VAR RV: MyString): BOOLEAN;
VAR
  Tmp: MyString;
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 3
  DO
    BEGIN
      IF (Res = FALSE)
      THEN
        BEGIN
          Tmp := 'а' + PerfectiveGerundGroup1[I];
          IF (IsEndOn(Rv, Tmp))
          THEN
            BEGIN
              Res := TRUE;
              DeleteEnding(Rv, Tmp);
            END;
          IF (Res = FALSE)
          THEN
            BEGIN
              Tmp := 'я' + PerfectiveGerundGroup1[I];
              IF (IsEndOn(Rv, Tmp))
              THEN
                BEGIN
                  Res := TRUE;
                  DeleteEnding(Rv, Tmp)
                END
            END
        END
    END;
  IF Res = FALSE
  THEN
    FOR I := 1 TO 6
    DO
      BEGIN
        IF (Res = FALSE)
        THEN
          IF (IsEndOn(Rv, PerfectiveGerundGroup2[I]))
          THEN
            BEGIN
              Res := TRUE;
              DeleteEnding(Rv, Tmp)
            END
      END;
  DeletePerfectiveGerund := Res
END;

FUNCTION DeleteReflexive(VAR Rv: MyString): BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 2
  DO
    BEGIN
      IF (Res = FALSE)
      THEN
        IF IsEndOn(Rv, Reflexive[I])
        THEN
          BEGIN
            Res := TRUE;
            DeleteEnding(Rv, Reflexive[I])
          END
    END;
  DeleteReflexive := Res
END;

FUNCTION IsDeleteAdjective(VAR Rv: MyString): BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 26
  DO
    BEGIN
      IF (Res = FALSE)
      THEN
        IF (IsEndOn(Rv, Adjective[I]))
        THEN
          BEGIN
            DeleteEnding(Rv, Adjective[I]);
            Res := TRUE
          END
    END;
  IsDeleteAdjective := Res;
END;

PROCEDURE TryDeleteParticiple(VAR Rv: MyString);
VAR
  Tmp: MyString;
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 5
  DO
    BEGIN
      IF (Res = FALSE)
      THEN
        Tmp := 'а' + ParticipleGroup1[I];
        IF (IsEndOn(Rv, Tmp))
        THEN
          BEGIN
            Res := TRUE;
            DeleteEnding(Rv, Tmp)
          END;
        IF (Res = FALSE)
        THEN
          BEGIN
            Tmp := 'я' + ParticipleGroup1[I];
            IF (IsEndOn(Rv, Tmp))
            THEN
              BEGIN
                Res := TRUE;
                DeleteEnding(Rv, Tmp)
              END
          END
    END;
  IF Res = FALSE
  THEN
    FOR I := 1 TO 3
    DO
      BEGIN
        IF Res = FALSE
        THEN
          IF IsEndOn(Rv, ParticipleGroup2[I])
          THEN
            BEGIN
              Res := TRUE;
              DeleteEnding(Rv, ParticipleGroup2[I])
            END
      END
END;

FUNCTION DeleteAdjectival(VAR Rv: MyString): BOOLEAN;
VAR
  Tmp: MyString;
  Res: BOOLEAN;
BEGIN
  Tmp := Rv;
  Res := FALSE;
  IF (IsDeleteAdjective(Rv))
  THEN
    BEGIN
      Res := TRUE;
      TryDeleteParticiple(Rv);
    END;
  DeleteAdjectival := Res
END;

FUNCTION DeleteVerb(VAR Rv: MyString): BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
  Tmp: MyString;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 17
  DO
    BEGIN
      IF Res = FALSE
      THEN
        BEGIN
          Tmp := 'а' + VerbGroup1[I];
          IF (IsEndOn(Rv, Tmp))
          THEN
            BEGIN
              Res := TRUE;
              DeleteEnding(Rv, Tmp)
            END;
          IF Res = FALSE
          THEN
            BEGIN
              Tmp := 'я' + VerbGroup1[I];
              IF (IsEndOn(Rv, Tmp))
              THEN
                BEGIN
                  Res := TRUE;
                  DeleteEnding(Rv, Tmp)
                END
            END
        END
    END;
  IF Res = FALSE
  THEN
    FOR I := 1 TO 29
    DO
      BEGIN
        IF Res = FALSE
        THEN
          IF IsEndOn(Rv, VerbGroup2[I])
          THEN
            BEGIN
              Res := TRUE;
              DeleteEnding(Rv, VerbGroup2[I])
            END
      END;
  DeleteVerb := Res;
END;

PROCEDURE TryDeleteNoun(VAR Rv: MyString);
VAR
  I: INTEGER;
  Res: BOOLEAN;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 36
  DO
    BEGIN
      IF Res = FALSE
        THEN
          IF IsEndOn(Rv, Noun[I])
          THEN
            BEGIN
              DeleteEnding(Rv, Noun[I]);
              Res := TRUE
            END
    END
END;

PROCEDURE DeleteDerivational(VAR Rv, R2: MyString);
VAR
  Tmp: MyString;
BEGIN
  IF (LENGTH(R2) >= 4)
  THEN
    BEGIN
      Tmp := COPY(R2, LENGTH(R2) - 4, LENGTH(R2));
      IF Tmp = Derivational[2]
      THEN
        RV := COPY(Rv, 1, LENGTH(Rv) - 4)
    END
  ELSE
    IF (LENGTH(R2) >= 3)
    THEN
      BEGIN
        Tmp := COPY(R2, LENGTH(R2) - 3, LENGTH(R2));
        IF Tmp = Derivational[1]
        THEN
          Rv := COPY(Rv, 1, LENGTH(Rv) - 3)
      END;
END;

FUNCTION DeleteSuperlative(VAR Rv: MyString):BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 2
  DO
    IF Res = FALSE
    THEN
      IF (IsEndOn(Rv, Superlative[I]))
      THEN
        BEGIN
          Res := TRUE;
          DeleteEnding(Rv, Superlative[I])
        END;
  DeleteSuperlative := Res
END;

FUNCTION GetWordRoot(VAR AnalizedWord: MyString): MyString;
VAR
  R0, Rv, R1, R2, Tmp: MyString;
BEGIN
  SetWordAreas(AnalizedWord, R0, Rv, R1, R2);
  IF NOT (DeletePerfectiveGerund(Rv))
  THEN
    IF NOT DeleteReflexive(Rv)
    THEN
      IF NOT DeleteAdjectival(Rv)
      THEN
        IF NOT DeleteVerb(Rv)
        THEN
          TryDeleteNoun(Rv);
  Tmp := 'и';
  IF IsEndOn(Rv, Tmp)
  THEN
    DeleteEnding(Rv, Tmp);
  DeleteDerivational(Rv, R2);

  Tmp := 'нн';
  IF IsEndOn(Rv, Tmp)
  THEN
    Rv := Copy(Rv, 1, LENGTH(Rv) - 1)
  ELSE
    IF (DeleteSuperlative(Rv))
    THEN
      BEGIN
        Tmp := 'нн';
        IF IsEndOn(Rv, Tmp)
        THEN
          Rv := Copy(Rv, 1, LENGTH(Rv) - 1)
      END
    ELSE
      BEGIN
        Tmp := 'ь';
        IF IsEndOn(Rv, Tmp)
        THEN
          Rv := COPY(Rv, 1, LENGTH(Rv) - 1);
      END;
  IF Rv <> ''
  THEN
    GetWordRoot := R0 + Rv
  ELSE
    GetWordRoot := ''
END;

FUNCTION ToLowerCase(Ch: CHAR): CHAR;
VAR
  I: INTEGER;
  IsFindChar: BOOLEAN;
BEGIN
  ToLowerCase := Ch;
  IF (Ch = AdditionChar1) OR (Ch = AdditionChar2)
  THEN
    ToLowerCase := 'е'
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
