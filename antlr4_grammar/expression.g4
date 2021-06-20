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
   | STRLEN LPAREN (IDENTIFIER | STRING_LITERAL) RPAREN
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
   : BINARY_LITERAL
   | HEX_LITERAL
   | DEC_LITERAL
   | CHAR_LITERAL
   ;

CHAR_LITERAL
   : '\'' CHAR '\''
   ;

fragment
CHAR
    : [\u0020-\u007E] 
    ;

BINARY_LITERAL
   : '0b'[01]+
   ;

HEX_LITERAL
   : '0x'[0-9a-fA-F]+
   ;

DEC_LITERAL
   : [0-9]+
   ;

// ======= String Literal =====
STRING_LITERAL
    :  '"' CHAR_SEQUENCE? '"'
    ;

fragment
CHAR_SEQUENCE
    :   CHAR+
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

WS: [ \t]+ -> skip ;
EOL: [\r\n]+ -> skip;
