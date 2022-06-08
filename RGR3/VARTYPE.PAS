UNIT VarType;

INTERFACE

CONST
  StartChar = '#';
  MaxTreeNodes = 1000;
  MaxStringSize = 50;
  CompatibleChars: STRING[69] = 'abcdefghijklmnopqrstuvwxyz ¡¢£¤¥¦§¨©ª«¬­®¯àáâãäåæçèéêëìíîï-';
  UpperChars: STRING[58] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ';
  AdditionChar1 = 'ğ';
  AdditionChar2 = 'ñ';
  ResultFileName: STRING = 'result.txt';
  TempFileName: STRING = 'temp.tmp';

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

VAR
  ReadedString: MyString;

IMPLEMENTATION

BEGIN
END.
