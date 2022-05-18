PROGRAM SarahRevere(INPTUT, OUTPUT);
USES FindMsg;

CONST
  MinWindow = 1;
  MaxWindow = 4;

VAR
  SarahSay: MsgType;
  Window: ARRAY[MinWindow .. MaxWindow] OF CHAR;
  I: MinWindow .. MaxWindow;

BEGIN
  //Initialize
  SarahSay := NoMessage;
  FOR I := MinWindow TO MaxWindow
  DO
    BEGIN
      Window[I] := ' ';
    END;

  //Read message from input
  WHILE (NOT EOLN) AND (SarahSay = NoMessage)
  DO
    BEGIN
      //MoveWindow
      FOR I := MinWindow TO (MaxWindow - 1)
      DO
        Window[I] := Window[I + 1];

      //Read char from input
      READ(Window[MaxWindow]);

      //Check window
      //IsLand
      IF (Window[MaxWindow - 3] = 'L') OR (Window[MaxWindow - 3] = 'l') THEN
      IF (Window[MaxWindow - 2] = 'A') OR (Window[MaxWindow - 2] = 'a') THEN
      IF (Window[MaxWindow - 1] = 'N') OR (Window[MaxWindow - 1] = 'n') THEN
      IF (Window[MaxWindow] = 'D') OR (Window[MaxWindow] = 'd') THEN
        SarahSay := land;
      //IsSea
      IF (Window[MaxWindow - 2] = 'S') OR (Window[MaxWindow - 2] = 's') THEN
      IF (Window[MaxWindow - 1] = 'E') OR (Window[MaxWindow - 1] = 'e') THEN
      IF (Window[MaxWindow] = 'A') OR (Window[MaxWindow] = 'a') THEN
        SarahSay := sea;
      //IsAir
      IF (Window[MaxWindow - 2] = 'A') OR (Window[MaxWindow - 2] = 'a') THEN
      IF (Window[MaxWindow - 1] = 'I') OR (Window[MaxWindow - 1] = 'i') THEN
      IF (Window[MaxWindow] = 'R') OR (Window[MaxWindow] = 'r') THEN
        SarahSay := air;
    END;
  IF SarahSay = NoMessage
  THEN
    WRITELN('Sarah did''n say')
  ELSE
    BEGIN
      WRITE('The British coming by ');

      IF (SarahSay = sea)
      THEN
        WRITELN('sea')
      ELSE
        IF (SarahSay = land)
        THEN
          WRITELN('land')
        ELSE
          IF (SarahSay = air)
          THEN
            WRITELN('air')
    END
END.
