GRAMMAR_NAME=Hello
GRAMMAR_COMPILE_FLAG=.compiled_grammar
ANTLR4_CMD=antlr4

GENERATE_TESTS=
# Enable generation by uncommenting the following line
# GENERATE_TESTS=python3 generate_line_tests.py

.PHONY: test
test: $(GRAMMAR_COMPILE_FLAG)
	$(GENERATE_TESTS)
	python3 test_grammar.py

$(GRAMMAR_COMPILE_FLAG): antlr4_grammar/$(GRAMMAR_NAME).g4 makefile
	$(ANTLR4_CMD) -Dlanguage=Python3 antlr4_grammar/$(GRAMMAR_NAME).g4
	touch $(GRAMMAR_COMPILE_FLAG)
	
.PHONY: clean
clean:
	rm antlr4_grammar/*.py antlr4_grammar/*.interp antlr4_grammar/*.tokens -rf
	rm test_outs/* -rf
	rm $(GRAMMAR_COMPILE_FLAG) -rf
	rm tests/*_autogen.txt -rf
