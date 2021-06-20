# ANTLR4 Python3 Testbench
Philipp Schilk

A very rudimentary ANTLR4 grammar testbench written in python.

# Usage

## Requirements

Tested under Ubuntu/Linux. The test script should work on window too, the makefile probably not.

Requires antlr4 and the antlr4-python3-runtime. Their versions must match.

## Running the tests
Every test is a text file in `tests/`

Running `make` will generate the python parser from the grammar, parse every 
test file in `tests/` and print the results to both stdout and a result file in `test_outs/`.

## Changing Grammar:
To use a different grammar:  
    - Add your .g4 grammar file to `antlr4_grammar/`  
    - Change the GRAMMAR_NAME variable in the makefile  
    - Adapt the test_grammar.py file to the new Lexer/Parser names and starting rule (Follow the `TODO` comments).  

