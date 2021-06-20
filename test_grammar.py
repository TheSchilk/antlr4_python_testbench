import antlr4
from antlr4.InputStream import InputStream
from antlr4.tree.Trees import Trees
from antlr4.error.ErrorListener import ErrorListener
from antlr4.Utils import escapeWhitespace
from os.path import isfile, join
from os import listdir

# TODO import the correct lexer and parser class
from antlr4_grammar.psASMLexer import psASMLexer
from antlr4_grammar.psASMParser import psASMParser


def toVisualStringTree(t, recog, prefix):
    result = ""
    node = escapeWhitespace(Trees.getNodeText(t, recog.ruleNames), False)
    result += prefix + node + '\n'
    for i in range(0, t.getChildCount()):
        result += toVisualStringTree(t.getChild(i), recog, prefix + '  ')

    return result


class TestErrorListener(ErrorListener):
    def __init__(self, gtest):
        self.gtest = gtest

    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        self.gtest.did_error = True
        self.gtest.print("line " + str(line) + ":" + str(column) + " " + msg)
        pass


class GrammarTest:
    def __init__(self, test_file_name, in_file, out_file):
        self.test_file_name = test_file_name
        self.in_file = in_file
        self.out_file = out_file
        self.did_error = False

    def print(self, txt):
        # Print to both stdout and test result file
        self.out_file.write(str(txt)+'\n')
        print(txt)

    def test(self):
        inp = self.in_file.read()

        # Make sure error messages get printed to result file and stdout
        error_listener = TestErrorListener(self)

        # Visual seperator (only in stdout)
        print('===========================================')

        # Test header
        self.print("Test %s:" % self.test_file_name)
        self.print("Input:")
        self.print(inp)

        self.print("Errors:")

        # TODO instantiate the correct lexer class
        lexer = psASMLexer(InputStream(inp))
        lexer.removeErrorListeners()
        lexer.addErrorListener(error_listener)
        stream = antlr4.CommonTokenStream(lexer)

        # TODO instantiate the correct parser class
        parser = psASMParser(stream)
        parser.removeErrorListeners()
        parser.addErrorListener(error_listener)

        # TODO call the correct starting rule
        tree = parser.line()

        # Print resulting tree in bracket notation
        self.print("")
        self.print("Bracket Tree:")
        self.print(Trees.toStringTree(tree, None, parser))

        # Print resulting tree visually
        self.print("")
        self.print("Tree:")
        self.print(toVisualStringTree(tree, parser, ""))


def main():
    test_folder = 'tests'
    out_folder = 'test_outs'
    test_files = [f for f in listdir(
        test_folder) if isfile(join(test_folder, f))]

    errored_tests = []

    for test_file_name in test_files:
        with open(join(test_folder, test_file_name), 'r') as in_file:
            with open(join(out_folder, test_file_name), 'w') as out_file:
                gtest = GrammarTest(test_file_name, in_file, out_file)
                gtest.test()
                if gtest.did_error:
                    errored_tests.append(gtest)

    print('===========================================')
    if len(errored_tests) == 0:
        print("No test errored.")
    else:
        print("%i test(s) errored:" % len(errored_tests))
        for err_test in errored_tests:
            print("  " + err_test.test_file_name)


if __name__ == '__main__':
    main()
