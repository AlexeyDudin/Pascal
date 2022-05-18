UNIT Sarah;

INTERFACE

PROCEDURE RunSarahRevere;

IMPLEMENTATION

CONST
  MaxWindowSize = 4; {����� ������ ࠧ��� ����
                      ��� ���������� ᮮ�饭��
                      ����� ᯮᮡ�� �ਤ�� ��⠭��
                      ���ਬ�� UNDERGROUND => MaxWindowSize = 11}

TYPE
  MessageType = (NoMessage, Land, Air, Sea); {��� ᮮ�饭�� ����}

VAR
  Window: ARRAY[1 .. MaxWindowSize] OF CHAR; {����}
  SarahMessage: MessageType; {����饭�� ����}

PROCEDURE MoveWindow;
VAR
  I: 1 .. MaxWindowSize;
BEGIN {MoveWindow}
  FOR I := 1 TO (MaxWindowSize - 1)
  DO
    Window[I] := Window[I + 1]
END; {MoveWindow}

FUNCTION IsAir: BOOLEAN;
BEGIN {IsAir}
  IsAir := FALSE;
  IF (Window[MaxWindowSize - 2] = 'A') OR (Window[MaxWindowSize - 2] = 'a')
  THEN
    IF (Window[MaxWindowSize - 1] = 'I') OR (Window[MaxWindowSize - 1] = 'i')
    THEN
      IF (Window[MaxWindowSize] = 'R') OR (Window[MaxWindowSize] = 'r')
        THEN IsAir := TRUE
END; {IsAir}

FUNCTION IsSea: BOOLEAN;
BEGIN {IsSea}
  IsSea := FALSE;
  IF (Window[MaxWindowSize - 2] = 'S') OR (Window[MaxWindowSize - 2] = 's')
  THEN
    IF (Window[MaxWindowSize - 1] = 'E') OR (Window[MaxWindowSize - 1] = 'e')
    THEN
      IF (Window[MaxWindowSize] = 'A') OR (Window[MaxWindowSize] = 'a')
        THEN IsSea := TRUE
END; {IsSea}

FUNCTION IsLand: BOOLEAN;
BEGIN {IsLand}
  IsLand := FALSE;
  IF (Window[MaxWindowSize - 3] = 'L') OR (Window[MaxWindowSize - 3] = 'l')
  THEN
    IF (Window[MaxWindowSize - 2] = 'A') OR (Window[MaxWindowSize - 2] = 'a')
    THEN
      IF (Window[MaxWindowSize - 1] = 'N') OR (Window[MaxWindowSize - 1] = 'n')
      THEN
        IF (Window[MaxWindowSize] = 'D') OR (Window[MaxWindowSize] = 'd')
        THEN
          IsLand := TRUE
END; {IsLand}

PROCEDURE CheckMessage(VAR SarahMessage: MessageType);
BEGIN {CheckMessage}
  IF IsAir
  THEN
    SarahMessage := air
  ELSE
    IF IsLand
    THEN
      SarahMessage := land
    ELSE
      IF IsSea
      THEN
        SarahMessage := sea
END; {CheckMessage}

PROCEDURE WriteSarahMessage(VAR SarahMessage: MessageType);
BEGIN {WriteSarahMessage}
  {�᫨ ��祣� �� ᪠���� � ���⠥� ᮮ�饭�� Sarah didn't say}
  IF (SarahMessage = NoMessage)
  THEN
    WRITELN('Sarah didn''t say')
  ELSE
    BEGIN
      {���� ���⠥� ᭠砫� �� ��� ����ந� �� ��⠭楢,
      ��᫥ ���⠥� ����� ᯮᮡ�� ��� �ਤ��}
      WRITE('The British coming by ');

      IF (SarahMessage = sea)
      THEN
        WRITELN('sea')
      ELSE
        IF (SarahMessage = air)
        THEN
          WRITELN('air')
        ELSE
          IF (SarahMessage = land)
          THEN
            WRITELN('land')
    END
END; {WriteSarahMessage}

PROCEDURE InitializeWindow;
VAR
  I: 1 .. MaxWindowSize;
BEGIN {InitializeWindow}
  FOR I := 1 TO MaxWindowSize
  DO
    Window[I] := ' '
END; {InitializeWindow}

PROCEDURE RunSarahRevere;
VAR
  I: INTEGER;
BEGIN {RunSarahRevere}
  {���⪠ ����}
  InitializeWindow;

  {���� �� ����� ��ப� ��� �� ��諨 ��ࢮ� �宦����� ᮮ�饭��}
  WHILE (NOT EOLN) AND (SarahMessage = NoMessage)
  DO
    BEGIN
      {��६�頥� ����}
      MoveWindow;
      {��⠥� � ��᫥���� ᨬ��� ����}
      READ(Window[MaxWindowSize]);
      {�஢�ઠ ���� �� ᮮ�饭��}
      CheckMessage(SarahMessage)
    END;

  {���⠥� �� �࠭ �� ᪠���� ���}
  WriteSarahMessage(SarahMessage)
END; {RunSarahRevere}

BEGIN {Sarah}
END. {Sarah}
