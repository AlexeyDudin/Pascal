UNIT VarType;

INTERFACE

TYPE
  Endings = STRING[6];

CONST
  StartChar = '#';
  MaxTreeNodes = 1000;
  MaxStringSize = 50;
  CompatibleChars: STRING[69] = 'abcdefghijklmnopqrstuvwxyzабвгдежзийклмнопрстуфхцчшщъыьэюя-';
  UpperChars: STRING[58] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
  AdditionChar1 = 'Ё';
  AdditionChar2 = 'ё';
  ResultFileName: STRING = 'result.txt';
  TempFileName: STRING = 'temp.tmp';
  Vowels: string[9] = 'аеиоуыэюя';
  PerfectiveGerundGroup1: ARRAY[1..3] OF Endings = ('в', 'вши', 'вшись');
  PerfectiveGerundGroup2: ARRAY[1..6] OF Endings = ('ив', 'ивши', 'ившись', 'ыв', 'ывши', 'ывшись');
  Adjective: ARRAY[1..26] OF Endings = ('ее','ие', 'ые', 'ое', 'ими', 'ыми', 'ей', 'ий', 'ый', 'ой' , 'ем',
                                       'им', 'ым', 'ом', 'его', 'ого', 'ему', 'ому', 'их', 'ых',
                                       'ую', 'юю', 'ая', 'яя', 'ою', 'ею');
  ParticipleGroup1: ARRAY[1..5] OF Endings = ('ем', 'нн', 'вш', 'ющ', 'щ');
  ParticipleGroup2: ARRAY[1..3] OF Endings = ('ивш', 'ывш', 'ующ');
  Reflexive: ARRAY[1..2] OF Endings = ('ся', 'сь');
  VerbGroup1: ARRAY[1..17] OF Endings = ('ла', 'на', 'ете', 'йте', 'ли', 'й', 'л', 'ем', 'н', 'ло',
                                        'но', 'ет', 'ют', 'ны', 'ть', 'ешь', 'нно');
  VerbGroup2: ARRAY[1..29] OF Endings = ('ила', 'ыла', 'ена', 'ейте', 'уйте', 'ите', 'или', 'ыли', 'ей', 'уй',
                                        'ил', 'ыл', 'им', 'ым', 'ен', 'ило', 'ыло', 'ено', 'ят', 'ует', 'уют',
                                        'ит', 'ыт', 'ены', 'ить', 'ыть', 'ишь', 'ую', 'ю');

  Noun: ARRAY[1..36] OF Endings = ('а', 'ев', 'ов', 'ие', 'ье', 'е', 'иями', 'ями', 'ами', 'еи',
                                  'ии', 'и', 'ией', 'ей', 'ой', 'ий', 'й', 'иям', 'ям', 'ием',
                                  'ем', 'ам', 'ом', 'о', 'у', 'ах', 'иях', 'ях', 'ы', 'ь',
                                  'ию', 'ью', 'ю', 'ия', 'ья', 'я');
  SuperLative: ARRAY[1..2] OF Endings = ('ейш', 'ейше');

  Derivational: ARRAY[1..2] OF Endings = ('ост', 'ость');


TYPE
  MyString = STRING[MaxStringSize];

  TreeNodePtr = ^TreeNode;
  TreeNode = RECORD
    Name: MyString;
    Count: INTEGER;
    Left, Rigth: TreeNodePtr
  END;

  StackNodePtr = ^StackNode;
  StackNode = RECORD
    Node: TreeNodePtr;
    Next: StackNodePtr
  END;

  WordRootPtr = ^WordRoot;
  WordRoot = RECORD
    Root: MyString;
    FullWord: MyString;
    Count: INTEGER;
    Next: WordRootPtr
  END;

  StoragePtr = ^Storage;
  Storage = RECORD
    Root: MyString;
    TreeOfWords: TreeNodePtr;
    Count: INTEGER;
    Next: StoragePtr
  END;


VAR
  ReadedString: MyString;

IMPLEMENTATION

BEGIN
END.
