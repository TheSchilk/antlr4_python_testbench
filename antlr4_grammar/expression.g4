grammar expression;

expr
   : LPAREN expr RPAREN
   | (PLUS | MINUS | NOT | BIT_NOT) expr 
   | expr (DIV | MUL | MOD) expr
   | expr (PLUS | MINUS) expr
   | expr (LSHFIT | RSHIFT) expr
   | expr (LESS | LESS_EQ | GREATER | GREATER_EQ) expr
   | expr (EQ | NEQ ) expr
   | expr (BIT_AND) expr
   | expr (BIT_XOR) expr
   | expr (BIT_OR) expr
   | expr (AND) expr
   | expr (OR) expr
   | expr TERN_A expr TERN_B expr
   | atom
   ;

atom
   : numerical_literal
   | DEFINED LPAREN IDENTIFIER RPAREN
   | STRLEN LPAREN (IDENTIFIER | String_Literal) RPAREN
   | IDENTIFIER
   ;

// ======= Operators =======

DEFINED: 'defined' ;
STRLEN: 'strlen' ;

LPAREN: '(' ;
RPAREN: ')' ;

NOT: '!' ;
BIT_NOT: '~' ;

DIV: '/' ;
MUL: '*' ;
MOD: '%' ;

PLUS: '+' ;
MINUS: '-' ;

LSHFIT: '<<' ;
RSHIFT: '>>' ;

LESS: '<' ;
LESS_EQ: '<=' ;
GREATER: '>' ;
GREATER_EQ: '>=' ;

EQ: '==' ;
NEQ: '!=' ;

BIT_AND: '&' ;
BIT_XOR: '^' ;
BIT_OR: '|' ;

AND: '&&' ;
OR: '||' ;

TERN_A: '?' ;
TERN_B: ':' ;

// ======= Numerical Literals =======

numerical_literal
   : Binary_Literal
   | Hex_Literal
   | Dec_Literal
   | Char_Literal
   ;

Char_Literal
   : '\'' Char '\''
   ;

fragment
Char
    : [\u0020-\u007E] 
    ;

Binary_Literal
   : '0b'[01]+
   ;

Hex_Literal
   : '0x'[0-9a-fA-F]+
   ;

Dec_Literal
   : [0-9]+
   ;

// ======= String Literal =====
String_Literal
    :  '"' CharSequence? '"'
    ;

fragment
CharSequence
    :   Char+
    ;

// ======= Identifiers =====

fragment
IDENTIFIER_FIRST_CHAR
   : [._$a-zA-Z] 
   ;

fragment
IDENTIFIER_OTHER_CHAR
   : [a-zA-Z0-9]
   ;


IDENTIFIER
   : IDENTIFIER_FIRST_CHAR (IDENTIFIER_OTHER_CHAR+)?
   ;


// ======= Others =======

Whitespace: [ \t]+ -> skip ;

EOL: [\r\n]+ -> skip;
