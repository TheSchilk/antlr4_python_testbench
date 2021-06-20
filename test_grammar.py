import antlr4
from antlr4.InputStream import InputStream
from antlr4.tree.Trees import Trees
from antlr4.error.ErrorListener import ErrorListener
from os.path import isfile, join
from os import listdir

# TODO import the correct lexer and parser class
from antlr4_grammar.HelloLexer import HelloLexer
from antlr4_grammar.HelloParser import HelloParser


class TestErrorListener(ErrorListener):
    def __init__(self, gtest):
        self.gtest = gtest

    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        self.gtest.print("line " + str(line) + ":" + str(column) + " " + msg)


class GrammarTest:
    def __init__(self, test_file_name, in_file, out_file):
        self.test_file_name = test_file_name
        self.in_file = in_file
        self.out_file = out_file

    def print(self, txt):
        self.out_file.write(str(txt)+'\n')
        print(txt)

    def test(self):
        inp = self.in_file.read()

        error_listener = TestErrorListener(self)

        self.print("Test %s:" % self.test_file_name)
        self.print("Input:")
        self.print(inp)

        # TODO instantiate the correct lexer class
        lexer = HelloLexer(InputStream(inp))
        lexer.removeErrorListeners()
        lexer.addErrorListener(error_listener)
        stream = antlr4.CommonTokenStream(lexer)

        # TODO instantiate the correct parser class
        parser = HelloParser(stream)
        parser.removeErrorListeners()
        parser.addErrorListener(error_listener)

        # TODO call the correct starting rule
        tree = parser.r()

        self.print(Trees.toStringTree(tree, None, parser))

        print("")
        print("")
        print("")


def main():
    test_folder = 'tests'
    out_folder = 'test_outs'
    test_files = [f for f in listdir(
        test_folder) if isfile(join(test_folder, f))]

    for test_file_name in test_files:
        with open(join(test_folder, test_file_name), 'r') as in_file:
            with open(join(out_folder, test_file_name), 'w') as out_file:
                gtest = GrammarTest(test_file_name, in_file, out_file)
                gtest.test()


if __name__ == '__main__':
    main()
