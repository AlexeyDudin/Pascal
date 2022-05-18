PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper
  и печатает новые символы в OUTPUT}
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
VAR
  F: TEXT;
  ChSymb, ChCode: CHAR;
{Присвоить Code шифр замены}
BEGIN {Initialize}
  ASSIGN(F, 'CODE.TXT');
  RESET(F);
  WHILE NOT EOF(F)
  DO
    BEGIN
      READ(F, ChSymb);
      IF ChSymb IN ['A' .. 'Z']
      THEN
        BEGIN
          READ(F, ChCode);
          Code[ChSymb] := ChCode
        END;
      READLN(F)
    END;
  CLOSE(F)
END;  {Initialize}

PROCEDURE Encode(VAR S: CurrMess);
{Выводит символы из Code, соответствующие символам из S}
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
  {Инициализировать Code}
  Initialize(Code);
  StrLen := 0;
  WHILE NOT EOLN
  DO
    BEGIN
      {читать строку в Msg и распечатать ее}
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

      {распечатать кодированное сообщение}
      Encode(CurrMsg)
    END
END.  {Encryption}
