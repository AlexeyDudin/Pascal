UNIT States;

INTERFACE

TYPE
  StatesType = (B, W, S); {B - Start(Begin), W - Word, S - Space}

PROCEDURE SetStateToStart;
PROCEDURE SetStateToWord;
PROCEDURE SetStateToSpace;

FUNCTION IsStateWord: BOOLEAN;
FUNCTION IsStateSpace: BOOLEAN;

IMPLEMENTATION
VAR
  State: StatesType;

PROCEDURE SetStateToStart;
BEGIN
  State := B
END;

PROCEDURE SetStateToWord;
BEGIN
  State := W
END;

PROCEDURE SetStateToSpace;
BEGIN
  State := S
END;

FUNCTION IsStateWord: BOOLEAN;
BEGIN
  IsStateWord := FALSE;
  IF State = W
  THEN
    IsStateWord := TRUE
END;

FUNCTION IsStateSpace: BOOLEAN;
BEGIN
  IsStateSpace := FALSE;
  IF State = S
  THEN
    IsStateSpace := TRUE
END;

BEGIN
END.
