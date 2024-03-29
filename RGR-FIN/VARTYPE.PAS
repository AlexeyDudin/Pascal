UNIT VarType;

INTERFACE

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
TYPE
  MyString = STRING[MaxStringSize];

CONST
  PerfectiveGerundGroup1: ARRAY[1..3] OF MyString = ('�', '��', '����');
  PerfectiveGerundGroup2: ARRAY[1..6] OF MyString = ('��', '���', '�����', '�', '��', '����');
  Adjective: ARRAY[1..26] OF MyString = ('��','��', '�', '��', '���', '묨', '��', '��', '�', '��' , '��',
                                       '��', '�', '��', '���', '���', '���', '���', '��', '��',
                                       '��', '��', '��', '��', '��', '��');
  ParticipleGroup1: ARRAY[1..5] OF MyString = ('��', '��', '��', '��', '�');
  ParticipleGroup2: ARRAY[1..3] OF MyString = ('���', '��', '���');
  Reflexive: ARRAY[1..2] OF MyString = ('��', '��');
  VerbGroup1: ARRAY[1..17] OF MyString = ('��', '��', '��', '��', '��', '�', '�', '��', '�', '��',
                                        '��', '��', '��', '��', '��', '���', '���');
  VerbGroup2: ARRAY[1..29] OF MyString = ('���', '뫠', '���', '���', '��', '��', '���', '뫨', '��', '�',
                                        '��', '�', '��', '�', '��', '���', '뫮', '���', '��', '��', '���',
                                        '��', '��', '���', '���', '���', '���', '��', '�');

  Noun: ARRAY[1..36] OF MyString = ('�', '��', '��', '��', '�', '�', '�ﬨ', 'ﬨ', '���', '��',
                                  '��', '�', '���', '��', '��', '��', '�', '��', '�', '���',
                                  '��', '��', '��', '�', '�', '��', '���', '��', '�', '�',
                                  '��', '��', '�', '��', '��', '�');
  SuperLative: ARRAY[1..2] OF MyString = ('���', '���');

  Derivational: ARRAY[1..2] OF MyString = ('���', '����');

TYPE
  WordNodePtr = ^WordNode;
  WordNode = RECORD
    Name: MyString;
    Next: WordNodePtr
  END;

  StorageNodePtr = ^StorageNode;
  StorageNode = RECORD
    Name: MyString;
    Count: INTEGER;
    Words: WordNodePtr;
    Next: StorageNodePtr;
  END;
IMPLEMENTATION

BEGIN
END.
