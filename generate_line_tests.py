# A generate a test file from each line of an input file
# Can be run automatically before every run. See makefile.

from os.path import join

# TODO Set input file
input_file = 'input.psASM'
test_folder = 'tests'

with open(input_file, 'r') as in_file:
    lines = in_file.readlines()
    test_digits = len(str(len(lines)))
    for index, line in enumerate(lines):
        output_name = ("%s_test_autogen.txt" % str(index).zfill(test_digits))
        with open(join(test_folder, output_name), 'w') as out_file:
            out_file.write(line)
