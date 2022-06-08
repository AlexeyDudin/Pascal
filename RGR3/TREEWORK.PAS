UNIT TreeWork;

INTERFACE
USES VarType, MyStack;

{PROCEDURE SetPtrToLowerWord;}
FUNCTION GetCurrWordOfTree: TreeNodePtr;
PROCEDURE InitTreeWorker(VAR Root: TreeNodePtr);
PROCEDURE NextWordOfTree;

IMPLEMENTATION
VAR
  RootOfTree: TreeNodePtr;

PROCEDURE SetPtrToLowerWord;
BEGIN
  WHILE (RootOfTree^.Left <> NIL)
  DO
    BEGIN
      Push(RootOfTree);
      RootOfTree := RootOfTree^.Left
    END
END;

FUNCTION GetCurrWordOfTree: TreeNodePtr;
BEGIN
  GetCurrWordOfTree := RootOfTree
END;

PROCEDURE InitTreeWorker(VAR Root: TreeNodePtr);
BEGIN
  RootOfTree := Root;
  SetPtrToLowerWord
END;

PROCEDURE NextWordOfTree;
BEGIN
  IF (RootOfTree^.Rigth <> NIL)
  THEN
    BEGIN
      RootOfTree := RootOfTree^.Rigth;
      SetPtrToLowerWord
    END
  ELSE
    RootOfTree := Pop;
END;

BEGIN
  RootOfTree := NIL;
END.