UNIT LTRARR;

INTERFACE
CONST
  MaxElem = 25;
  MaxChars = 10;
  InvalidSymbol = '#';
  PrintedSymbol = '#';

TYPE
  LetterSet = SET OF 1 .. MaxElem;

TYPE
  ChArr = ARRAY[1 .. MaxChars] OF CHAR;

TYPE
  LetterArray = ARRAY[1 .. MaxChars] OF LetterSet;

PROCEDURE FillAllLetterArray(Str: ChArr);
PROCEDURE WriteAllLetter;

IMPLEMENTATION
TYPE
  Ltrs = SET OF 1 .. 255;

VAR
  AllLeters: Ltrs;
  LettrArr: LetterArray;

PROCEDURE ChangeModifyer(J: BYTE; VAR Modifyer: INTEGER);
BEGIN
  IF (J >= 1) AND (J <= 5)
  THEN
    Modifyer := 0
  ELSE
    IF (J >= 6) AND (J <= 10)
    THEN
      Modifyer := 50
    ELSE
      IF (J >= 11) AND (J <= 15)
      THEN
        Modifyer := 100
      ELSE
        IF (J >= 16) AND (J <= 20)
        THEN
          Modifyer := 150
        ELSE
          IF (J >= 21) AND (J <= 25)
          THEN
            Modifyer := 200
END;

PROCEDURE FillAllLeters;
VAR
  I, Modifyer: INTEGER;
  J: BYTE;
BEGIN
  FOR I := 1 TO MaxChars
  DO
    BEGIN
      FOR J := 1 TO MaxElem
      DO
        BEGIN
          IF (J IN LettrArr[I])
          THEN
            BEGIN
              ChangeModifyer(J, Modifyer);
              IF ((J MOD 5) = 0)
              THEN
                AllLeters := AllLeters + [5 + (5 * (I - 1)) + Modifyer]
              ELSE
                AllLeters := AllLeters + [(J MOD 5) + (5 * (I - 1)) + Modifyer]
            END
        END
    END
END;

PROCEDURE FillSetZeroes(VAR LettrArr: LetterArray);
VAR
  I: BYTE;
BEGIN
  FOR I := 1 TO MaxChars
  DO
    LettrArr[I] := [];
    {LettrArr[I] := [1 .. MaxElem];}
END;

PROCEDURE FillSetFromFile(Str: ChArr; VAR LettrArr: LetterArray);
VAR
  F: TEXT;
  Ch: CHAR;
  I, J: BYTE;
  IntSet: INTEGER;
  IsFound: BOOLEAN;
BEGIN
  ASSIGN(F, 'TextLtr.TXT');
  RESET(F);

  WHILE NOT EOF(F)
  DO
    BEGIN
      IsFound := FALSE;
      READ(F, Ch);
      FOR I := 1 TO MaxChars
      DO
        BEGIN
          IF (Str[I] = Ch)
          THEN
            BEGIN
              LettrArr[I] := [];
              IF IsFound
              THEN
                FOR J := 1 TO (I - 1)
                DO
                  BEGIN
                    IF (Str[I] = Str[J])
                    THEN
                      BEGIN
                        LettrArr[I] := LettrArr[J];
                        BREAK
                      END
                  END
              ELSE
                BEGIN
                  WHILE NOT EOLN(F)
                  DO
                    BEGIN
                      READ(F, IntSet);
                      LettrArr[I] := LettrArr[I] + [IntSet]
                    END;
                  IsFound := TRUE
                END
            END
        END;

      READLN(F);
    END;

  CLOSE(F)
END;

PROCEDURE FillAllLetterArray(Str: ChArr);
VAR
  I: BYTE;
  TempLetterSet: LetterSet;
BEGIN
  I := 1;
  FillSetZeroes(LettrArr);
  FillSetFromFile(Str, LettrArr);
  FillAllLeters;
END;

PROCEDURE WriteAllLetter;
VAR
  I: BYTE;
BEGIN
  FOR I := 1 TO 250
  DO
    BEGIN
      IF I IN AllLeters
      THEN
        WRITE(OUTPUT, PrintedSymbol)
      ELSE
        WRITE(OUTPUT, ' ');

      IF (I MOD 5) = 0
      THEN
        WRITE(OUTPUT, ' ');
      IF (I MOD 50) = 0
      THEN
        WRITELN(OUTPUT);
    END
END;

BEGIN
  AllLeters := [];
END.
