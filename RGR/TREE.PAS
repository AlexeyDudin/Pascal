UNIT Tree;

INTERFACE

USES VarType;

PROCEDURE AddWordInStorage(AddedWord: MyString);
PROCEDURE PrintStorage(VAR OutputFile: TEXT);
PROCEDURE AddResidueTreeInFile;

IMPLEMENTATION

USES StWorker, MyStack;

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

{
PROCEDURE SendNodesInStack(VAR StartNode: TreeNodePtr);
BEGIN
  IF (StartNode <> NIL)
  THEN
    BEGIN
      SendNodesInStack(StartNode^.Left);
      Push(StartNode);
      SendNodesInStack(StartNode^.Rigth);
      RemoveTree(StartNode)
    END
END;                       }

PROCEDURE WriteNodeInFile(VAR FileToWrite: TEXT; VAR Node: TreeNodePtr);
BEGIN
  WRITE(FileToWrite, Node^.Name);
  WRITE(FileToWrite, ' ');
  WRITELN(FileToWrite, Node^.Count)
END;

PROCEDURE WriteAllNodes(VAR FileToWrite: TEXT; VAR Root: TreeNodePtr);
BEGIN
  IF (Root <> NIL)
  THEN
    BEGIN
      WriteAllNodes(FileToWrite, Root^.Left);
      WriteNodeInFile(FileToWrite, Root);
      WriteAllNodes(FileToWrite, Root^.Rigth);
      RemoveTree(Root)
    END
END;

PROCEDURE RemoveNodeFromTree(VAR Node: TreeNodePtr);
VAR
  TmpNode: TreeNodePtr;
BEGIN
  {Очищаем ноду с меньшим словом}
  TmpNode := Node;
  Node := Node^.Rigth;
  TmpNode^.Rigth := NIL;
  RemoveTree(TmpNode)
END;

PROCEDURE MergeWithTree(VAR TmpFile: TEXT; VAR ReadedNode, Root: TreeNodePtr);
BEGIN
  IF (Root <> NIL)
  THEN
    BEGIN
      IF (ReadedNode <> NIL)
      THEN
        BEGIN
          IF (ReadedNode^.Name = Root^.Name)
          THEN
            BEGIN
              ReadedNode^.Count := ReadedNode^.Count + Root^.Count;
              IF (Root^.Left <> NIL)
              THEN
                WriteAllNodes(TmpFile, Root^.Left);
              WriteNodeInFile(TmpFile, ReadedNode);

              {TODO Delete this node from tree}
              RemoveNodeFromTree(Root)
            END
          ELSE
            IF (IsFirstLowerSecond(Root^.Name, ReadedNode^.Name)) {Если текущая нода в дереве меньше чем в файле}
            THEN
              BEGIN
                WriteAllNodes(TmpFile, Root^.Left); {Выводим ноды, что слева по дереву}
                WriteNodeInFile(TmpFile, Root); {Выводим текущую ноду, так-как она меньше считанной из файла}

                RemoveNodeFromTree(Root);

                {Рекурсивно}
                MergeWithTree(TmpFile, ReadedNode, Root)
              END
            ELSE {Если нода из файла меньше текущей из дерева}
              MergeWithTree(TmpFile, ReadedNode, Root^.Left)
        END
    END
  ELSE {Если пришла пустая ссылка на дерево}
    WriteNodeInFile(TmpFile, ReadedNode)
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

  WHILE NOT EOF(OldFile)
  DO
    BEGIN
      ReadedNode := ReadNodeFromFile(OldFile);
      IF (ReadedNode^.Name <> '')
      THEN
        BEGIN
          {Если есть с чем сравнивать}
          IF (Root <> NIL)
          THEN
            MergeWithTree(TmpFile, ReadedNode, Root)
          ELSE
            WriteNodeInFile(TmpFile, ReadedNode);
          IF (ReadedNode <> NIL)
          THEN
            DISPOSE(ReadedNode)
        END
    END;

  {Если в Root остались элементы - записываем их в файл}
  IF Root <> NIL
  THEN
    WriteAllNodes(TmpFile, Root);

  CLOSE(OldFile);
  CLOSE(TmpFile);

  ERASE(OldFile);
  RENAME(TmpFile, ResultFileName)
END;

PROCEDURE InsertWordInTree(VAR Root: TreeNodePtr; AddedWord: MyString);
BEGIN
  IF (Root = NIL)
  THEN
    BEGIN
      IF NodeCount >= MaxTreeNodes
      THEN
        FlashTreeInFile(Root);

      NodeCount := NodeCount + 1;
      New(Root);
      Root^.Name := AddedWord;
      Root^.Count := 1;
      Root^.Left := NIL;
      Root^.Rigth := NIL
    END
  ELSE
    BEGIN
      IF (Root^.Name = AddedWord)
      THEN
        Root^.Count := Root^.Count + 1
      ELSE
        BEGIN
          IF (IsFirstLowerSecond(AddedWord, Root^.Name))
          THEN
            InsertWordInTree(Root^.Left, AddedWord)
          ELSE
            InsertWordInTree(Root^.Rigth, AddedWord)
        END
    END
END;

PROCEDURE AddWordInStorage(AddedWord: MyString);
VAR
  CurrNode: TreeNodePtr;
BEGIN
{  }
  InsertWordInTree(Root, AddedWord)
END;

PROCEDURE AddResidueTreeInFile;
BEGIN
  FlashTreeInFile(Root)
END;

BEGIN
  Root := NIL;
  NodeCount := 0
END.
