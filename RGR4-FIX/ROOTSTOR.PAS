UNIT RootStor;

INTERFACE
USES VarType;

PROCEDURE AddInStorage(Node: WordRootPtr);
PROCEDURE PrintStorage(VAR OutputFile: TEXT);

IMPLEMENTATION
USES Tree, StWorker;

VAR
  RootOfStorage: StoragePtr;

PROCEDURE AddInMemory(VAR Root: StoragePtr; VAR Node: WordRootPtr);
BEGIN
  NEW(Root);
  Root^.Next := NIL;
  Root^.Root := Node^.Root;
  Root^.Count := Node^.Count;
  Root^.TreeOfWords := NIL;

  InsertWordInTree(Root^.TreeOfWords, Node^.FullWord)
END;

PROCEDURE InsertInStorage(VAR Root: StoragePtr; VAR Node: WordRootPtr);
VAR
  PrevNode, TmpRootNode, NewRootNode: StoragePtr;
  IsFound: BOOLEAN;
BEGIN
  PrevNode := NIL;
  NewRootNode := NIL;
  TmpRootNode := Root;

  IF (Root = NIL)
  THEN
    AddInMemory(Root, Node)
  ELSE
    BEGIN
      IsFound := FALSE;
      WHILE (TmpRootNode^.Next <> NIL) AND NOT (IsFound)
      DO
        BEGIN
          IF (TmpRootNode^.Root = Node^.Root)
          THEN
            BEGIN
              TmpRootNode^.Count := TmpRootNode^.Count + Node^.Count;
              IsFound := TRUE;
              InsertWordInTree(TmpRootNode^.TreeOfWords, Node^.FullWord)
            END
          ELSE
            BEGIN
              IF (IsFirstLowerSecond(Node^.Root, TmpRootNode^.Root))
              THEN
                BEGIN
                  AddInMemory(NewRootNode, Node);
                  NewRootNode^.Next := TmpRootNode;
                  IF (PrevNode <> NIL)
                  THEN
                    PrevNode^.Next := NewRootNode
                  ELSE
                    Root := NewRootNode;
                  IsFound := TRUE
                END
            END;
          PrevNode := TmpRootNode;
          TmpRootNode := TmpRootNode^.Next
        END;
      IF NOT (IsFound)
      THEN
        BEGIN
          IF (IsFirstLowerSecond(Node^.Root, TmpRootNode^.Root))
          THEN
            BEGIN
              AddInMemory(NewRootNode, Node);
              NewRootNode^.Next := TmpRootNode;
              IF (PrevNode <> NIL)
              THEN
                PrevNode^.Next := NewRootNode
              ELSE
                Root := NewRootNode
            END
          ELSE
            AddInMemory(TmpRootNode^.Next, Node);
        END
    END
END;

PROCEDURE AddInStorage(Node: WordRootPtr);
BEGIN
  InsertInStorage(RootOfStorage, Node);
END;

PROCEDURE PrintStorage(VAR OutputFile: TEXT);
VAR
  RootNode: StoragePtr;
BEGIN
  RootNode := RootOfStorage;

  WHILE RootNode <> NIL
  DO
    BEGIN
      RecourceTreeView(RootNode^.TreeOfWords, OutputFile);
      WRITELN(OutputFile, ' ', RootNode^.Count);
      RootNode := RootNode^.Next;
    END;
END;


BEGIN
  RootOfStorage := NIL;
END.
