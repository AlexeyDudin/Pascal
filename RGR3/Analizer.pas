UNIT Analizer;

INTERFACE

PROCEDURE AnalizeWord(InputWord: MyString);

IMPLEMENTATION

USES VarType;

VAR
  Rv, R1, R2: INTEGER;



PROCEDURE AnalizeWord(InputWord: MyString);
BEGIN
  SetWordAreas(InputWord, Rv, R1, R2);
END;

BEGIN
END.
