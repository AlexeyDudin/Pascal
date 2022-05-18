PROGRAM SortDate(INPUT, OUTPUT);

USES DateUnit;

VAR
  Copying: BOOLEAN;
  TempDate, VarDate: Date;
  TFile, DateFile: FileOfDate;
  FInput: TEXT;
  IsWriteTempDate: BOOLEAN;

PROCEDURE CopyOut(VAR DateFile: FileOfDate);
VAR
  VarDate: Date;
BEGIN {CopyOut}
  WHILE NOT EOF(DateFile)
  DO
    BEGIN
      READ(DateFile, VarDate);
      WriteDate(OUTPUT, VarDate);
      WRITELN
    END
END; {CopyOut}

PROCEDURE CopyFile(VAR Source, Dest: FileOfDate);
VAR
  TempDate: Date;
BEGIN
  WHILE NOT EOF(Source)
  DO
    BEGIN
      READ(Source, TempDate);
      WRITE(Dest, TempDate)
    END
END;

BEGIN {SortDate}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(TFile, 'TF.DAT');
  ASSIGN(FInput, 'FI.TXT');
  REWRITE(DateFile);
  RESET(FInput);

  WHILE NOT EOF(FInput)
  DO
    BEGIN
      RESET(DateFile);
      REWRITE(TFile);

      ReadDate(FInput, TempDate);
      READLN(FInput);

      IsWriteTempDate := FALSE;

      WHILE NOT EOF(DateFile)
      DO
        BEGIN
          READ(DateFile, VarDate);
          IF NOT IsWriteTempDate
          THEN
            IF (Less(TempDate, VarDate))
            THEN
              BEGIN
                WRITE(TFile, TempDate);
                IsWriteTempDate := TRUE
              END;
          WRITE(TFile, VarDate)
        END;

      IF NOT IsWriteTempDate
      THEN
        WRITE(TFile, TempDate);

      RESET(TFile);
      REWRITE(DateFile);
      CopyFile(TFile, DateFile)
    END;
  RESET(TFile);
  {Копируем DateFile в OUTPUT}
  CLOSE(TFile);
  CLOSE(FInput);

  RESET(DateFile);
  WHILE NOT EOF(DateFile)
  DO
    BEGIN
      READ(DateFile, VarDate);
      WriteDate(OUTPUT, VarDate);
      WRITELN(OUTPUT)
    END;

  CLOSE(DateFile);
END.{SortDate}
