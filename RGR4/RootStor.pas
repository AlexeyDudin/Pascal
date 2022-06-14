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

  InsertWordInTree(Root^.TreeOfWords, Node^.FullWord);
END;

PROCEDURE InsertInStorage(VAR Root: StoragePtr; VAR Node: WordRootPtr);
VAR
  TmpRootNode: StoragePtr;
  IsFound: BOOLEAN;
BEGIN
  IF (Root = NIL)
  THEN
    AddInMemory(Root, Node)
  ELSE
    BEGIN
      IsFound := FALSE;
      TmpRootNode := Root;
      WHILE (TmpRootNode^.Next <> NIL) AND (NOT IsFound)
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

            END;

          IF NOT IsFound
          THEN
            TmpRootNode := TmpRootNode^.Next;
        END;
      IF NOT IsFound
      THEN
        AddInMemory(TmpRootNode, Node);
    END;
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
