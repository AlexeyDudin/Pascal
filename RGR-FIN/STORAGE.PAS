UNIT Storage;
INTERFACE
USES VarType;

PROCEDURE AddInStorage(RootOfWord, Phrase: MyString; VAR Count: INTEGER);
PROCEDURE PrintStorage(VAR OutputFile: TEXT);

IMPLEMENTATION
USES StWorker;
VAR
  Root: StorageNodePtr;

PROCEDURE PrintStorage(VAR OutputFile: TEXT);
VAR
  TmpPtr: StorageNodePtr;
  TmpWordsPtr: WordNodePtr;
BEGIN
  TmpPtr := Root;
  WHILE TmpPtr <> NIL
  DO
    BEGIN
      TmpWordsPtr := TmpPtr^.Words;
      WHILE TmpWordsPtr^.Next <> NIL
      DO
        BEGIN
          WRITE(OutputFile, TmpWordsPtr^.Name, ', ');
          TmpWordsPtr:= TmpWordsPtr^.Next;
        END;
      WRITELN(OutputFile, TmpWordsPtr^.Name, ' ', TmpPtr^.Count);
      TmpPtr := TmpPtr^.Next
    END
END;

PROCEDURE InsertInList(VAR Root: WordNodePtr; Phrase: MyString);
VAR
  TmpPtr: WordNodePtr;
BEGIN
  IF (Root = NIL)
  THEN
    BEGIN
      NEW(Root);
      TmpPtr := Root;
    END
  ELSE
    BEGIN
      TmpPtr := Root;
      WHILE TmpPtr^.Next <> NIL
      DO
        TmpPtr := TmpPtr^.Next;
      NEW(TmpPtr^.Next);
      TmpPtr := TmpPtr^.Next
    END;
  TmpPtr^.Name := Phrase;
  TmpPtr^.Next := NIL
END;

PROCEDURE InsertInStorage(VAR Root: StorageNodePtr; VAR RootOfWord, Phrase: MyString; VAR Count: INTEGER);
VAR
  PrevPtr, TmpPtr, NewPtr: StorageNodePtr;
  IsFound, IsNewItem: BOOLEAN;
BEGIN
  IF (Root = NIL)
  THEN
    BEGIN
      NEW(Root);
      Root^.Name := RootOfWord;
      Root^.Next := NIL;
      Root^.Count := Count;
      Root^.Words := NIL;
      InsertInList(Root^.Words, Phrase);
    END
  ELSE
    BEGIN
      PrevPtr := NIL;
      IsFound := FALSE;
      IsNewItem := TRUE;
      TmpPtr := Root;
      WHILE (TmpPtr <> NIL) AND (NOT IsFound)
      DO
        BEGIN
          IF (RootOfWord = TmpPtr^.Name)
          THEN
            BEGIN
              IsNewItem := FALSE;
              IsFound := True;
              TmpPtr^.Count := TmpPtr^.Count + Count;
              InsertInList(TmpPtr^.Words, Phrase)
            END
          ELSE
            BEGIN
              IF (IsFirstLowerSecond(RootOfWord, TmpPtr^.Name))
              THEN
                IsFound := TRUE
              ELSE
                BEGIN
                  PrevPtr := TmpPtr;
                  TmpPtr := TmpPtr^.Next
                END
            END
        END;
      IF IsNewItem
      THEN
        BEGIN
          NEW(NewPtr);
          NewPtr^.Name := RootOfWord;
          NewPtr^.Count := Count;
          NewPtr^.Next := TmpPtr;
          NewPtr^.Words := NIL;
          InsertInList(NewPtr^.Words, Phrase);
          IF (PrevPtr = NIL)
          THEN
            Root := NewPtr
          ELSE
            PrevPtr^.Next := NewPtr
        END
    END;
END;

PROCEDURE AddInStorage(RootOfWord, Phrase: MyString; VAR Count: INTEGER);
BEGIN
  InsertInStorage(Root, RootOfWord, Phrase, Count)
END;

BEGIN
  Root := NIL;
END.