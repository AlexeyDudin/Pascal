PROGRAM Prime(INPUT, OUTPUT);


CONST
  MAX = 20;

TYPE
  SieveType = SET OF 2 .. MAX;

VAR
  Sieve: SieveType;

PROCEDURE FillSieve(VAR Sieve: SieveType);
BEGIN
  Sieve := [2 .. MAX];
END;

PROCEDURE CycledRemoveByModule(VAR Sieve: SieveType; M: INTEGER);
VAR
  Num: INTEGER;
BEGIN
  Num := M;

  WHILE Num <= MAX
  DO
    BEGIN
      Sieve := Sieve - [Num];
      Num := Num + M
    END
END;

PROCEDURE CycledDelete(VAR Sieve: SieveType);
VAR
  Num: INTEGER;
BEGIN
  WHILE Sieve <> []
  DO
    BEGIN
      Num := 2;
      WHILE Num <= MAX
      DO
        BEGIN
          IF Num IN Sieve
          THEN
            BEGIN
              WRITE(OUTPUT, Num, ', ');
              CycledRemoveByModule(Sieve, Num)
            END;
          Num := Num + 1
        END
    END
END;

BEGIN
  FillSieve(Sieve);
  CycledDelete(Sieve)
END.
