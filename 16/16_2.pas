PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN;

PROCEDURE Initialize(VAR W1, W2, W3, W4: CHAR; VAR Looking, Land, Sea: BOOLEAN);
BEGIN
  {���樠������}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := TRUE;
  Land := FALSE;
  Sea := FALSE
END;

BEGIN {SarahRevere}
  Initialize(W1, W2, W3, W4, Looking, Land, Sea);
  Looking := NOT EOLN;
  WHILE Looking AND NOT (Land OR Sea)
  DO
    BEGIN
      {�������� ����}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(INPUT, W4);

      {�஢�ઠ ���� �� land}
      IF ((W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd'))
      THEN
        Land := TRUE;
      {�஢�ઠ ���� �� sea}
      IF ((W2 = 's') AND (W3 = 'e') AND (W4 = 'a'))
      THEN
        Sea := TRUE;
      Looking := NOT EOLN
    END;
  {ᮧ����� ᮮ�饭�� Sarah}
  IF NOT Looking
  THEN
    WRITELN('��� ��祣� �� ��।���')
  ELSE
    IF (Land)
    THEN
      WRITELN('������ �� �����')
    ELSE
      IF (Sea)
      THEN
        WRITELN('������ �� ����')
END.  {SarahRevere}
