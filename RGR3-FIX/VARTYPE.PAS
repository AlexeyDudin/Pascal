UNIT VarType;

INTERFACE

TYPE
  Endings = STRING[6];

CONST
  StartChar = '#';
  MaxTreeNodes = 28000;
  MaxStringSize = 50;
  CompatibleChars: STRING[69] = 'abcdefghijklmnopqrstuvwxyz��������������������������������-';
  UpperChars: STRING[58] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ��������������������������������';
  AdditionChar1 = '�';
  AdditionChar2 = '�';
  ResultFileName: STRING = 'result.txt';
  TempFileName: STRING = 'temp.tmp';
  Vowels: string[9] = '���������';
  PerfectiveGerundGroup1: ARRAY[1..3] OF Endings = ('�', '��', '����');
  PerfectiveGerundGroup2: ARRAY[1..6] OF Endings = ('��', '���', '�����', '�', '��', '����');
  Adjective: ARRAY[1..26] OF Endings = ('��','��', '�', '��', '���', '묨', '��', '��', '�', '��' , '��',
                                       '��', '�', '��', '���', '���', '���', '���', '��', '��',
                                       '��', '��', '��', '��', '��', '��');
  ParticipleGroup1: ARRAY[1..5] OF Endings = ('��', '��', '��', '��', '�');
  ParticipleGroup2: ARRAY[1..3] OF Endings = ('���', '��', '���');
  Reflexive: ARRAY[1..2] OF Endings = ('��', '��');
  VerbGroup1: ARRAY[1..17] OF Endings = ('��', '��', '��', '��', '��', '�', '�', '��', '�', '��',
                                        '��', '��', '��', '��', '��', '���', '���');
  VerbGroup2: ARRAY[1..29] OF Endings = ('���', '뫠', '���', '���', '��', '��', '���', '뫨', '��', '�',
                                        '��', '�', '��', '�', '��', '���', '뫮', '���', '��', '��', '���',
                                        '��', '��', '���', '���', '���', '���', '��', '�');

  Noun: ARRAY[1..36] OF Endings = ('�', '��', '��', '��', '�', '�', '�ﬨ', 'ﬨ', '���', '��',
                                  '��', '�', '���', '��', '��', '��', '�', '��', '�', '���',
                                  '��', '��', '��', '�', '�', '��', '���', '��', '�', '�',
                                  '��', '��', '�', '��', '��', '�');
  SuperLative: ARRAY[1..2] OF Endings = ('���', '���');

  Derivational: ARRAY[1..2] OF Endings = ('���', '����');


TYPE
  MyString = STRING[MaxStringSize];

  TreeNodePtr = ^TreeNode;
  TreeNode = RECORD
    Name: MyString;
    Count: INTEGER;
    Left, Rigth: TreeNodePtr
  END;
  {
  StackNodePtr = ^StackNode;
  StackNode = RECORD
    Node: TreeNodePtr;
    Next: StackNodePtr
  END; }

  {WordRootPtr = ^WordRoot;
  WordRoot = RECORD
    Root: MyString;
    FullWord: MyString;
    Count: INTEGER;
    Next: WordRootPtr
  END;}

  {StoragePtr = ^Storage;
  Storage = RECORD
    Root: MyString;
    TreeOfWords: TreeNodePtr;
    Next: StoragePtr
  END;}

  WordsPtr = ^WordStruct;
  WordStruct = RECORD
    Name: MyString;
    Next: WordsPtr;
  END;

  StoragePtr = ^Storage;
  Storage = RECORD
    Root: MyString;
    Words: WordsPtr;
    Counter: INTEGER;
    Left: StoragePtr;
    Right: StoragePtr;
  END;


VAR
  ReadedString: MyString;

IMPLEMENTATION

BEGIN
END.
