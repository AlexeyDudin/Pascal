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

PROCEDURE RemoveEndings(VAR SubStr: ENDINGS; VAR Str: MyString);
BEGIN
  Str := COPY(Str, 1, LENGTH(Str) - LENGTH(SubStr));
END;

FUNCTION IsReplacePerfectiveGerund(Rv: MyString):BOOLEAN;
VAR
  I: INTEGER;
  Tmp: Endings;
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
  Tmp: Endings;
  TmpStr: MyString;
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
  Tmp: Endings;
BEGIN
  Res := FALSE;
  FOR I := 1 TO 17
  DO
    BEGIN
      Tmp := ' ' + VerbGroup1[I];
      IF (IsEndingsOn(Tmp, Rv))
      THEN