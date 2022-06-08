UNIT MyStack;

INTERFACE
USES VarType;

PROCEDURE Push(Elem: TreeNodePtr);
FUNCTION Pop:TreeNodePtr;
FUNCTION GetLastElem:TreeNodePtr;

IMPLEMENTATION

VAR
  RootStack: StackNodePtr;

PROCEDURE Push(Elem: TreeNodePtr);
VAR
  NewElem: StackNodePtr;
BEGIN
  New(NewElem);
  NewElem^.Node := Elem;
  NewElem^.Next := RootStack;
  RootStack := NewElem;
END;

FUNCTION Pop: TreeNodePtr;
VAR
  Res: TreeNodePtr;
  TmpStackNode: StackNodePtr;
BEGIN
  IF RootStack <> NIL
  THEN
    BEGIN
      TmpStackNode := RootStack;
      Res := RootStack^.Node;
      RootStack := RootStack^.Next;
      DISPOSE(TmpStackNode)
    END
  ELSE
    Res := NIL;
  Pop := Res
END;

FUNCTION GetLastElem:TreeNodePtr;
BEGIN
  IF (RootStack <> NIL)
  THEN
    GetLastElem := RootStack^.Node
  ELSE
    GEtLastElem := NIL
END;

BEGIN
  RootStack := NIL
END.
