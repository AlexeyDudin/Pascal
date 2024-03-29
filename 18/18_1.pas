PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  FirstReadedStudent, FirstReadedScore: BOOLEAN;
  Ave, TotalScore, ClassTotal: INTEGER;
BEGIN {AverageScore}
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;
  FirstReadedStudent := TRUE;
  WHILE Student < ClassSize
  DO
    BEGIN
      FirstReadedScore := TRUE;
      IF (FirstReadedStudent)
      THEN
        WRITELN('Input ', Student, ' score')
      ELSE
        WRITELN('Input ', Student + 1, ' score');
      TotalScore := 0;
      WhichScore := 1;
      WHILE WhichScore < NumberOfScores
      DO
        BEGIN
          READ(NextScore);
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
        IF (FirstReadedStudent)
        THEN
          WRITELN('Student ', Student, ': ', Ave DIV 10 + 1)
        ELSE
          WRITELN('Student ', Student + 1, ': ', Ave DIV 10 + 1)
      ELSE
        IF (FirstReadedStudent)
        THEN
          WRITELN('Student ', Student, ': ', Ave DIV 10)
        ELSE
          WRITELN('Student ', Student + 1, ': ', Ave DIV 10);
      ClassTotal := ClassTotal + TotalScore;
      IF FirstReadedStudent
      THEN
        FirstReadedStudent := FALSE
      ELSE
        INC(Student)
    END;
  WRITELN;
  WRITELN('Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
END.  {AverageScore}