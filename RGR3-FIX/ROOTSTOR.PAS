UNIT RootStor;

INTERFACE
USES VarType;

PROCEDURE AddInStorage(FullWord: MyString; Counter: INTEGER; RootOfWord: MyString);
PROCEDURE PrintStorage(VAR OutputFile: TEXT);

IMPLEMENTATION
USES StWorker;

VAR
  RootOfStorage: StoragePtr;

PROCEDURE InsertWordInStorage(VAR Words: WordsPtr; VAR FullWord: MyString);
VAR
  TmpWordsPtr: WordsPtr;
BEGIN
  IF (Words = NIL)
  THEN
    BEGIN
      NEW(Words);
      Words^.Name := FullWord;
      Words^.Next := NIL
    END
  ELSE
    BEGIN
      TmpWordsPtr := Words;
      WHILE TmpWordsPtr^.Next <> NIL
      DO
        TmpWordsPtr := TmpWordsPtr^.Next;
      NEW(TmpWordsPtr^.Next);
      TmpWordsPtr^.Next^.Next := NIL;
      TmpWordsPtr^.Next^.Name := FullWord
    END
END;

PROCEDURE InsertInStorage(VAR FullWord: MyString; VAR Counter: INTEGER; VAR RootOfWord: MyString; VAR Root: StoragePtr);
BEGIN
  IF (Root = NIL)
  THEN
    BEGIN
      NEW(Root);
      Root^.Root := RootOfWord;
      Root^.Left := NIL;
      Root^.Words := NIL;
      Root^.Counter := Counter;
      InsertWordInStorage(Root^.Words, FullWord);
      Root^.Right := NIL
    END
  ELSE
    BEGIN
      IF (Root^.Root = RootOfWord)
      THEN
        BEGIN
          InsertWordInStorage(Root^.Words, FullWord);
          Root^.Counter := Root^.Counter + Counter
        END
      ELSE
        BEGIN
          IF (IsFirstLowerSecond(Root^.Root, RootOfWord))
          THEN
            InsertInStorage(FullWord, Counter, RootOfWord, Root^.Right)
          ELSE
            InsertInStorage(FullWord, Counter, RootOfWord, Root^.Left)
        END;
    END;
END;

PROCEDURE AddInStorage(FullWord: MyString; Counter: INTEGER; RootOfWord: MyString);
BEGIN
  InsertInStorage(FullWord, Counter, RootOfWord, RootOfStorage);
END;

PROCEDURE RecourceTreeView(VAR Root: StoragePtr; VAR OutputFile: TEXT);
VAR
  TmpWordsPtr: WordsPtr;
BEGIN
  IF (Root <> NIL)
  THEN
    BEGIN
      RecourceTreeView(Root^.Left, OutputFile);
      TmpWordsPtr := Root^.Words;
      WHILE (TmpWordsPtr^.Next <> NIL)
      DO
        BEGIN
          WRITE(OutputFile, TmpWordsPtr^.Name, ', ');
          TmpWordsPtr := TmpWordsPtr^.Next
        END;
      WRITE(OutputFile, TmpWordsPtr^.Name, ' ', Root^.Counter);
      RecourceTreeView(Root^.Right, OutputFile)
    END
END;

PROCEDURE PrintStorage(VAR OutputFile: TEXT);
BEGIN
  RecourceTreeView(RootOfStorage, OutputFile);
END;

BEGIN
  RootOfStorage := NIL;
END.
