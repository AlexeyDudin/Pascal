UNIT Tree;

INTERFACE

USES VAR_TYPE;

PROCEDURE AddWordInTree(AddedWord: MyString);
{PROCEDURE InitVars;                 }
PROCEDURE PrintTree(VAR OutputFile: TEXT);

IMPLEMENTATION

USES StWorker;

TYPE
  TreeNodePtr = ^TreeNode;
  TreeNode = RECORD
    Name: MyString;
    Count: INTEGER;
    Left, Rigth: TreeNodePtr
  END;

VAR
  Root: TreeNodePtr;
  NodeCount: INTEGER;

PROCEDURE RecourceTreeView(ParentNode: TreeNodePtr; VAR OutputFile: TEXT);
BEGIN
  IF (ParentNode <> NIL)
  THEN
    BEGIN
      RecourceTreeView(ParentNode^.Left, OutputFile);
      WRITELN(OutputFile, ParentNode^.Name, ' ', ParentNode^.Count);
      RecourceTreeView(ParentNode^.Rigth, OutputFile);
    END
END;

PROCEDURE PrintTree(VAR OutputFile: TEXT);
BEGIN
  RecourceTreeView(Root, OutputFile)
END;

FUNCTION FindNodeByName(ParentNode: TreeNodePtr; AddedWord: MyString): TreeNodePtr;
VAR
  ReturnedNode: TreeNodePtr;
BEGIN
  FindNodeByName := NIL;
  IF ParentNode <> NIL
  THEN
    BEGIN
      IF (ParentNode^.Name = AddedWord)
      THEN
        FindNodeByName := ParentNode
      ELSE
        BEGIN
          IF (IsFirstLowerSecond(AddedWord, ParentNode^.Name))
          THEN
            ReturnedNode := FindNodeByName(ParentNode^.Left, AddedWord)
          ELSE
            ReturnedNode := FindNodeByName(ParentNode^.Rigth, AddedWord);
          FindNodeByName := ReturnedNode
        END
    END
END;

FUNCTION InsertWordInTree(ParentNode: TreeNodePtr; AddedWord: MyString): TreeNodePtr;
VAR
  NewNode: TreeNodePtr;
BEGIN
  IF (ParentNode = NIL)
  THEN
    BEGIN
      IF NodeCount < MaxTreeNodes
      THEN
        BEGIN
          NodeCount := NodeCount + 1;
          New(NewNode);
          NewNode^.Name := AddedWord;
          NewNode^.Count := 1;
          NewNode^.Left := NIL;
          NewNode^.Rigth := NIL;
          InsertWordInTree := NewNode;
        END
      ELSE
        BEGIN
          WRITE('ОШИБКА! Превышено количество нод');
          InsertWordInTree := NIL;
        END
    END
  ELSE
    BEGIN
      InsertWordInTree := NIL;
      IF (IsFirstLowerSecond(AddedWord, ParentNode^.Name))
      THEN
        BEGIN
          NewNode := InsertWordInTree(ParentNode^.Left, AddedWord);
          IF NewNode <> NIL
          THEN
            ParentNode^.Left := NewNode
        END
      ELSE
        BEGIN
          NewNode := InsertWordInTree(ParentNode^.Rigth, AddedWord);
          IF NewNode <> NIL
          THEN
            ParentNode^.Rigth := NewNode
        END
    END
END;

PROCEDURE AddWordInTree(AddedWord: MyString);
VAR
  CurrNode: TreeNodePtr;
BEGIN
  CurrNode := FindNodeByName(Root, AddedWord);
  IF (CurrNode <> NIL)
  THEN
    CurrNode^.Count := CurrNode^.Count + 1
  ELSE
    BEGIN
      CurrNode := InsertWordInTree(Root, AddedWord);
      IF (Root = NIL)
      THEN
        Root := CurrNode
    END
END;

BEGIN
  Root := NIL;
  NodeCount := 0;
END.