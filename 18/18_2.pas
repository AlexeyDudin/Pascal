PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
  SpaceConst = ' ';
  NotSpaceConst = '#';
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  FirstReadedStudent, FirstReadedScore: BOOLEAN;
  Ave, TotalScore, ClassTotal: INTEGER;
  ChName: CHAR;
  F: TEXT;
BEGIN {AverageScore}
  ASSIGN(F, 'inp.txt');
  RESET(F);
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;
  FirstReadedStudent := TRUE;
  WHILE Student < ClassSize
  DO
    BEGIN
      ChName := NotSpaceConst;
      WHILE ChName <> SpaceConst
      DO
        BEGIN
          READ(F, ChName);
          WRITE(OUTPUT, ChName)
        END;
      FirstReadedScore := TRUE;
      TotalScore := 0;
      WhichScore := 1;
      WHILE WhichScore < NumberOfScores
      DO
        BEGIN
          READ(F, NextScore);
          TotalScore := TotalScore + NextScore;
          IF (FirstReadedScore)
          THEN
            FirstReadedScore := FALSE
          ELSE
            INC(WhichScore)
        END;
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;
      IF Ave MOD 10 >= 5
      THEN
        WRITELN(OUTPUT, ': ', Ave DIV 10 + 1)
      ELSE
        WRITELN(OUTPUT, ': ', Ave DIV 10);

      {Flush Return}
      READLN(F);

      ClassTotal := ClassTotal + TotalScore;
      IF FirstReadedStudent
      THEN
        FirstReadedStudent := FALSE
      ELSE
        INC(Student)
    END;
  WRITELN;
  WRITELN(OUTPUT, 'Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
END.  {AverageScore}
