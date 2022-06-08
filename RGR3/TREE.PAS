UNIT Tree;

INTERFACE

USES VarType;

PROCEDURE AddWordInStorage(AddedWord: MyString);
PROCEDURE PrintStorage(VAR OutputFile: TEXT);
PROCEDURE AddResidueTreeInFile;

IMPLEMENTATION

USES StWorker, MyStack, TreeWork;

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
      RecourceTreeView(ParentNode^.Rigth, OutputFile)
    END
END;

PROCEDURE PrintStorage(VAR OutputFile: TEXT);
VAR
  F: TEXT;
  ReadIOResult: BYTE;
  TmpString: STRING;
BEGIN
  {RecourceTreeView(Root, OutputFile) v.1}
  {v.2}
  ASSIGN(F, ResultFileName);
  {$I-}
  RESET(F);
  ReadIOResult := IOResult;
  {$I+}
  WHILE NOT EOF(F)
  DO
    BEGIN
      READLN(F, TmpString);
      WRITELN(OutputFile, TmpString)
    END;
  CLOSE(F);
  ERASE(F)
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

PROCEDURE RemoveTree(VAR Root: TreeNodePtr);
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      RemoveTree(Root^.Left);
      RemoveTree(Root^.Rigth);
      DISPOSE(Root);
      Root := NIL;
      NodeCount := NodeCount - 1
    END
END;

FUNCTION ReadNodeFromFile(VAR FileOfNodes: TEXT): TreeNodePtr;
VAR
  Node: TreeNodePtr;
  Ch: CHAR;
BEGIN
  NEW(Node);
  Node^.Name := GetWord(FileOfNodes);
  READLN(FileOfNodes, Node^.Count);
  Node^.Left := NIL;
  Node^.Rigth := NIL;
  ReadNodeFromFile := Node
END;

PROCEDURE WriteNodeInFile(VAR FileToWrite: TEXT; VAR Node: TreeNodePtr);
BEGIN
  WRITE(FileToWrite, Node^.Name);
  WRITE(FileToWrite, ' ');
  WRITELN(FileToWrite, Node^.Count)
END;

PROCEDURE MergeWithTree(VAR TmpFile: TEXT; VAR ReadedNode: TreeNodePtr);
VAR
  WordInTree: TreeNodePtr;
BEGIN
  WordInTree := GetCurrWordOfTree;
  IF (WordInTree <> NIL)
  THEN
    BEGIN
      IF (ReadedNode^.Name = WordInTree^.Name)
      THEN
        BEGIN
          ReadedNode^.Count := ReadedNode^.Count + WordInTree^.Count;
          WriteNodeInFile(TmpFile, ReadedNode);
          NextWordOfTree;
          WordInTree := GetCurrWordOfTree
        END
      ELSE
        BEGIN
          WHILE ((WordInTree <> NIL) AND ((IsFirstLowerSecond(WordInTree^.Name, ReadedNode^.Name) AND (WordInTree^.Name <> ReadedNode^.Name))))
          DO
            BEGIN
              WriteNodeInFile(TmpFile, WordInTree);
              NextWordOfTree;
              WordInTree := GetCurrWordOfTree
            END;
          IF (WordInTree <> NIL) AND (WordInTree^.Name = ReadedNode^.Name)
          THEN
            BEGIN
              ReadedNode^.Count := ReadedNode^.Count + WordInTree^.Count;
              NextWordOfTree;
              WordInTree := GetCurrWordOfTree
            END;
          WriteNodeInFile(TmpFile, ReadedNode)
        END
    END
  ELSE
    WriteNodeInFile(TmpFile, ReadedNode)
END;

PROCEDURE WriteResidueTreeInFile(VAR TmpFile: TEXT);
VAR
  Node: TreeNodePtr;
BEGIN
  {Если остались элементы в дереве - записываем их в файл}
  Node := GetCurrWordOfTree;
  WHILE (Node <> NIL)
  DO
    BEGIN
      WriteNodeInFile(TmpFile, Node);
      NextWordOfTree;
      Node := GetCurrWordOfTree
    END
END;

PROCEDURE FlashTreeInFile(VAR Root: TreeNodePtr);
VAR
  OldFile, TmpFile: TEXT;
  ReadIOResult: BYTE;
  ReadedNode: TreeNodePtr;
BEGIN
  ASSIGN(OldFile, ResultFileName);
  {$I-}
  RESET(OldFile);
  ReadIOResult := IOResult;
  {$I+}

  {Создаем файл}
  IF (ReadIOResult <> 0)
  THEN
    BEGIN
      REWRITE(OldFile);
      CLOSE(OldFile);
      RESET(OldFile)
    END;

  ASSIGN(TmpFile, TempFileName);
  {$I-}
  REWRITE(TmpFile);
  ReadIOResult := IOResult;
  {$I+}

  InitTreeWorker(Root);

  WHILE NOT EOF(OldFile)
  DO
    BEGIN
      ReadedNode := ReadNodeFromFile(OldFile);
      IF (ReadedNode <> NIL)
      THEN
        BEGIN
          IF (ReadedNode^.Name <> '')
          THEN
            MergeWithTree(TmpFile, ReadedNode);
          DISPOSE(ReadedNode)
        END
    END;

  {Записываем остаток дерева в файл}
  WriteResidueTreeInFile(TmpFile);

  {Очищаем дерево}
  RemoveTree(Root);

  CLOSE(OldFile);
  CLOSE(TmpFile);

  ERASE(OldFile);
  RENAME(TmpFile, ResultFileName);
END;

PROCEDURE InsertWordInTree(VAR Parent: TreeNodePtr; AddedWord: MyString);
BEGIN
  IF (Parent = NIL)
  THEN
    BEGIN
      IF NodeCount >= MaxTreeNodes
      THEN
        BEGIN
          FlashTreeInFile(Root);
          New(Root);
          Parent := Root
        END
      ELSE
        New(Parent);
      NodeCount := NodeCount + 1;
      Parent^.Name := AddedWord;
      Parent^.Count := 1;
      Parent^.Left := NIL;
      Parent^.Rigth := NIL
    END
  ELSE
    BEGIN
      IF (Parent^.Name = AddedWord)
      THEN
        Parent^.Count := Parent^.Count + 1
      ELSE
        BEGIN
          IF (IsFirstLowerSecond(AddedWord, Parent^.Name))
          THEN
            InsertWordInTree(Parent^.Left, AddedWord)
          ELSE
            InsertWordInTree(Parent^.Rigth, AddedWord);
        END
    END
END;

PROCEDURE AddWordInStorage(AddedWord: MyString);
VAR
  CurrNode: TreeNodePtr;
BEGIN
  InsertWordInTree(Root, AddedWord);
END;

PROCEDURE AddResidueTreeInFile;
BEGIN
  FlashTreeInFile(Root);
END;

BEGIN
  Root := NIL;
  NodeCount := 0
END.
