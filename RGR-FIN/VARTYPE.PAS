UNIT VarType;

INTERFACE

CONST
  StartChar = '#';
  MaxTreeNodes = 28000;
  MaxStringSize = 50;
  CompatibleChars: STRING[69] = 'abcdefghijklmnopqrstuvwxyzабвгдежзийклмнопрстуфхцчшщъыьэюя-';
  UpperChars: STRING[58] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
  AdditionChar1 = 'Ё';
  AdditionChar2 = 'ё';
  ResultFileName: STRING = 'result.txt';
  TempFileName: STRING = 'temp.tmp';
  Vowels: string[9] = 'аеиоуыэюя';
TYPE
  MyString = STRING[MaxStringSize];

CONST
  PerfectiveGerundGroup1: ARRAY[1..3] OF MyString = ('в', 'вши', 'вшись');
  PerfectiveGerundGroup2: ARRAY[1..6] OF MyString = ('ив', 'ивши', 'ившись', 'ыв', 'ывши', 'ывшись');
  Adjective: ARRAY[1..26] OF MyString = ('ее','ие', 'ые', 'ое', 'ими', 'ыми', 'ей', 'ий', 'ый', 'ой' , 'ем',
                                       'им', 'ым', 'ом', 'его', 'ого', 'ему', 'ому', 'их', 'ых',
                                       'ую', 'юю', 'ая', 'яя', 'ою', 'ею');
  ParticipleGroup1: ARRAY[1..5] OF MyString = ('ем', 'нн', 'вш', 'ющ', 'щ');
  ParticipleGroup2: ARRAY[1..3] OF MyString = ('ивш', 'ывш', 'ующ');
  Reflexive: ARRAY[1..2] OF MyString = ('ся', 'сь');
  VerbGroup1: ARRAY[1..17] OF MyString = ('ла', 'на', 'ете', 'йте', 'ли', 'й', 'л', 'ем', 'н', 'ло',
                                        'но', 'ет', 'ют', 'ны', 'ть', 'ешь', 'нно');
  VerbGroup2: ARRAY[1..29] OF MyString = ('ила', 'ыла', 'ена', 'ейте', 'уйте', 'ите', 'или', 'ыли', 'ей', 'уй',
                                        'ил', 'ыл', 'им', 'ым', 'ен', 'ило', 'ыло', 'ено', 'ят', 'ует', 'уют',
                                        'ит', 'ыт', 'ены', 'ить', 'ыть', 'ишь', 'ую', 'ю');

  Noun: ARRAY[1..36] OF MyString = ('а', 'ев', 'ов', 'ие', 'ье', 'е', 'иями', 'ями', 'ами', 'еи',
                                  'ии', 'и', 'ией', 'ей', 'ой', 'ий', 'й', 'иям', 'ям', 'ием',
                                  'ем', 'ам', 'ом', 'о', 'у', 'ах', 'иях', 'ях', 'ы', 'ь',
                                  'ию', 'ью', 'ю', 'ия', 'ья', 'я');
  SuperLative: ARRAY[1..2] OF MyString = ('ейш', 'ейше');

  Derivational: ARRAY[1..2] OF MyString = ('ост', 'ость');

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
