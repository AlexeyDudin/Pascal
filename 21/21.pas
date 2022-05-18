PROGRAM Encryption(INPUT, OUTPUT);
{��ॢ���� ᨬ���� �� INPUT � ��� ᮣ��᭮ Chiper
  � ���⠥� ���� ᨬ���� � OUTPUT}
CONST
  Len = 20;
TYPE
  InputedChar = 'A' .. 'Z';
  Str = ARRAY [1 .. Len] OF InputedChar;
  CurrMess = ARRAY [1.. Len] OF CHAR;
  StrLenType = 0 .. Len;
  Chiper = ARRAY [InputedChar] OF CHAR;
VAR
  Msg: Str;
  CurrMsg: CurrMess;
  Code: Chiper;
  Ch: CHAR;
  StrLen: StrLenType;
  I: INTEGER;

PROCEDURE Initialize(VAR Code: Chiper);
{��᢮��� Code ��� ������}
BEGIN {Initialize}
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'I';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A'
END;  {Initialize}

PROCEDURE Encode(VAR S: CurrMess);
{�뢮��� ᨬ���� �� Code, ᮮ⢥�����騥 ᨬ����� �� S}
VAR
  Index: 1 .. Len;
BEGIN {Encode}
  FOR Index := 1 TO StrLen
  DO
    IF S[Index] IN ['A' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      IF (S[Index] = ' ')
      THEN
        WRITE('\')
      ELSE
        WRITE(S[Index]);
  WRITELN
END;  {Encode}

BEGIN {Encryption}
  {���樠����஢��� Code}
  Initialize(Code);
  StrLen := 0;
  WHILE NOT EOLN
  DO
    BEGIN
      {���� ��ப� � Msg � �ᯥ���� ��}
      WHILE NOT EOLN AND (I < Len)
      DO
        BEGIN
          I := I + 1;
          StrLen := I;
          READ(CurrMsg[I]);
          WRITE(CurrMsg[I]);

        END;
      READLN;
      WRITELN;

      {�ᯥ���� ����஢����� ᮮ�饭��}
      Encode(CurrMsg)
    END
END.  {Encryption}
