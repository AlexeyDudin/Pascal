UNIT Analizer;

INTERFACE
USES VarType;

FUNCTION Analize(InputNode: TreeNodePtr): WordRootPtr;
PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile:TEXT);

IMPLEMENTATION
USES Tree, StWorker, RootStor;

VAR
  Root: WordRootPtr;

FUNCTION IsEndingsOn(SubStr, Rv: MyString): BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := TRUE;
  IF (LENGTH(Rv) > LENGTH(SubStr))
  THEN
    BEGIN
      FOR I := LENGTH(Rv) DOWNTO LENGTH(Rv) - LENGTH(SubStr) + 1
      DO
        IF (Rv[I] <> SubStr[LENGTH(SubStr) - (LENGTH(Rv) - I)])
        THEN
           Res := FALSE;
    END
  ELSE
    Res := FALSE;
  IsEndingsOn := Res
END;

PROCEDURE RemoveEndings(VAR SubStr, Str: MyString);
BEGIN
  Str := COPY(Str, 1, LENGTH(Str) - LENGTH(SubStr));
END;

FUNCTION IsReplacePerfectiveGerund(Rv: MyString):BOOLEAN;
VAR
  I: INTEGER;
  Tmp: MyString;
  Res: BOOLEAN;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 3
  DO
    BEGIN
      Tmp := ' ' + PerfectiveGerundGroup1[I];
      IF (IsEndingsOn(Tmp, Rv))
      THEN
        BEGIN
          RemoveEndings(Tmp, Rv);
          Res := TRUE;
          BREAK
        END
      ELSE
        BEGIN
          Tmp := 'ï' + PerfectiveGerundGroup1[I];
          IF (IsEndingsOn(Tmp, Rv))
          THEN
            BEGIN
              Res := TRUE;
              RemoveEndings(Tmp, Rv);
              BREAK
            END;
        END
    END;
  IF (Res = FALSE)
  THEN
    FOR I := 1 TO 6
    DO
      BEGIN
        IF (IsEndingsOn(PerfectiveGerundGroup2[I], Rv))
        THEN
          BEGIN
            RemoveEndings(PerfectiveGerundGroup2[I], Rv);
            Res := TRUE;
            BREAK
          END
      END;
  IsReplacePerfectiveGerund := Res;
END;

FUNCTION IsReplaceReflexive(VAR Rv: MyString): BOOLEAN;
VAR
  RES: BOOLEAN;
  I: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 2
  DO
    BEGIN
      IF (IsEndingsOn(Reflexive[I], Rv))
      THEN
        BEGIN
          RemoveEndings(Reflexive[I], Rv);
          Res := TRUE;
          BREAK
        END
    END;
  IsReplaceReflexive := Res
END;

FUNCTION IsRemoveAdjectival(VAR Rv: MyString): BOOLEAN;
VAR
  Res, IsFoundParticiple : BOOLEAN;
  TmpStr, Tmp: MyString;
  I, J: INTEGER;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 26
  DO
    BEGIN
      IF (IsEndingsOn(Adjective[I], Rv))
      THEN
        BEGIN
          TmpStr := Rv;
          IsFoundParticiple := FALSE;
          RemoveEndings(Adjective[I], TmpStr);
          FOR J := 1 TO 5
          DO
            BEGIN
              Tmp := ' ' + ParticipleGroup1[J];
              IF (IsEndingsOn(Tmp, TmpStr))
              THEN
                BEGIN
                  IsFoundParticiple := TRUE;
                  Res := TRUE;
                  RemoveEndings(Tmp, TmpStr);
                  Rv := TmpStr
                END;
              IF NOT (IsFoundParticiple)
              THEN
                BEGIN
                  Tmp := 'ï' + ParticipleGroup1[J];
                  IF (IsEndingsOn(Tmp, TmpStr))
                  THEN
                    BEGIN
                      IsFoundParticiple := TRUE;
                      Res := TRUE;
                      RemoveEndings(Tmp, TmpStr);
                      Rv := TmpStr
                    END;
                END
              END;
          IF NOT (IsFoundParticiple)
          THEN
            FOR J := 1 TO 3
            DO
              IF (IsEndingsOn(ParticipleGroup2[J], TmpStr))
              THEN
                BEGIN
                  IsFoundParticiple := TRUE;
                  Res := TRUE;
                  RemoveEndings(ParticipleGroup2[J], TmpStr);
                  BREAK
                END
        END
    END;
  IsRemoveAdjectival := Res
END;

FUNCTION IsRemoveVerb(VAR Rv: MyString):BOOLEAN;
VAR
  Res: BOOLEAN;
  I: INTEGER;
  Tmp: MyString;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 17
  DO
    BEGIN
      Tmp := ' ' + VerbGroup1[I];
      IF (IsEndingsOn(Tmp, Rv))
      THEN
        BEGIN
          Res := TRUE;
          RemoveEndings(Tmp, Rv);
          BREAK
        END;
      IF NOT (Res)
      THEN
        BEGIN
          Tmp := 'ï' + VerbGroup1[I];
          IF (IsEndingsOn(Tmp, Rv))
          THEN
            BEGIN
              Res := TRUE;
              RemoveEndings(Tmp, Rv);
              BREAK
            END
        END
    END;
  IF NOT Res
  THEN
    FOR I := 1 TO 29
    DO
      BEGIN
        IF (IsEndingsOn(VerbGroup2[I], Rv))
        THEN
          BEGIN
            Res := TRUE;
            RemoveEndings(VerbGroup2[I], Rv);
            BREAK
          END
      END;
  IsRemoveVerb := Res
END;

PROCEDURE TryRemoveNoun(VAR Rv: MyString);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO 36
  DO
    BEGIN
      IF (IsEndingsOn(Noun[I], Rv))
      THEN
        BEGIN
          RemoveEndings(Noun[I], Rv);
          BREAK
        END
    END
END;

PROCEDURE TryRemoveDerivational(VAR Rv, R2: MyString);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO 2
  DO
    BEGIN
      IF (IsEndingsOn(Derivational[I], R2))
      THEN
        BEGIN
          RemoveEndings(Derivational[I], R2);
          //TODO
          RemoveEndings(Derivational[I], Rv);
          BREAK
        END
    END
END;

FUNCTION IsRemoveSuperative(VAR Rv: MyString): BOOLEAN;
VAR
  I: INTEGER;
  Res: BOOLEAN;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 2
  DO
    BEGIN
      IF (IsEndingsOn(SuperLative[I], Rv))
      THEN
        BEGIN
          RemoveEndings(SuperLative[I], Rv);
          Res := TRUE;
          BREAK
        END
    END;
  IsRemoveSuperative := Res
END;

PROCEDURE RemoveEndings(VAR Rv, R1, R2: MyString);
BEGIN
  IF NOT (IsReplacePerfectiveGerund(Rv))
  THEN
    IF NOT (IsReplaceReflexive(Rv))
    THEN
      IF NOT (IsRemoveAdjectival(Rv))
      THEN
        IF NOT (IsRemoveVerb(Rv))
        THEN
          TryRemoveNoun(Rv);

  IF Rv[Length(Rv)] = '¨'
  THEN
    Rv := COPY(Rv, 1, Length(Rv) - 1);

  TryRemoveDerivational(Rv, R2);

  IF (Rv[Length(Rv) - 1] = '­') AND (Rv[Length(Rv)] = '­')
  THEN
    Rv := COPY(Rv, 1, Length(Rv) - 1)
  ELSE
    IF (IsRemoveSuperative(Rv))
    THEN
      IF (Rv[Length(Rv) - 1] = '­') AND (Rv[Length(Rv)] = '­')
      THEN
        Rv := COPY(Rv, 1, Length(Rv) - 1)
    ELSE
      IF (Rv[Length(Rv)] = 'ì')
      THEN
        Rv := COPY(Rv, 1, Length(Rv) - 1)
END;

FUNCTION Analize(InputNode: TreeNodePtr): WordRootPtr;
VAR
  Res: WordRootPtr;
  Rv, R1, R2: MyString;
BEGIN
  New(Res);
  Res^.FullWord := InputNode^.Name;
  Res^.Count := InputNode^.Count;
  Res^.Next := NIL;
  SetWordAreas(InputNode^.Name, Rv, R1, R2);
  IF (Rv <> '')
  THEN
    RemoveEndings(Rv, R1, R2);
  Res^.Root := Rv;
  Analize := Res;
END;

PROCEDURE CountNumberOfWordsFrom(VAR InputFile, OutputFile:TEXT);
VAR
  ReadedNode: TreeNodePtr;
  ReadedWordRoot: WordRootPtr;
BEGIN
  REPEAT
    ReadedNode := ReadNodeFromFile(InputFile);
    ReadedWordRoot := Analize(ReadedNode);
    IF (ReadedWordRoot^.Root <> '')
    THEN
      AddInStorage(ReadedWordRoot);

    DISPOSE(ReadedNode);
    {DISPOSE(ReadedWordRoot)}
  UNTIL EOF(InputFile);
  PrintStorage(OutputFile);
END;

BEGIN
  Root := NIL
END.
