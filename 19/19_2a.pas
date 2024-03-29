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
END;{CopyOut}

BEGIN {SortDate}
  ASSIGN(DateFile, 'DF.DAT');
  ASSIGN(FInput, 'FI.TXT');
  REWRITE(DateFile);
  RESET(FInput);

  ReadDate(FInput, VarDate);

  WriteDate(OUTPUT, VarDate);

  ReadDate(FInput, TempDate);
  IF (Less(TempDate, VarDate))
  THEN
    WRITE(OUTPUT, 'First date less second date')
  ELSE
    WRITE(OUTPUT, 'Second date less first date');

  {
  WHILE NOT EOF(DateFile)
  DO
    BEGIN
      READ(DateFile, VarDate);
      WriteDate(OUTPUT, VarDate);
      WRITELN(OUTPUT)
    END;
  }
  CLOSE(FInput);
  CLOSE(DateFile);
END.{SortDate}
