import re
import sys
import argparse
import os


# Define the way we retrieve arguments sent to the script.
parser = argparse.ArgumentParser(description='Process Textfiles in a Directory')
parser.add_argument('--overwrite', action='store_true')
parser.add_argument('--folder', action="store", dest='dir', default='')
args = parser.parse_args()

for dirpath, dirnames, files in os.walk(args.dir):
    for name in files:
        print(name)
        textfile = open(os.path.join(dirpath, name), "r")

        cleaned_filename = re.sub(r'\.\.[\\\/]', r'', name)
        output_directory = 'test_test'
        output_filename = os.path.join(output_directory, cleaned_filename)
        directory = os.path.dirname(output_filename)
        if not os.path.exists(directory):
            os.makedirs(directory)

        output_file = open(output_filename, 'w')
        text = textfile.read()
        lines = text.split("\n")
        for line in lines:
            if re.match("(d|D)olphin \^", line):
                line1 = re.sub("np", "nn", line)
                output_file.write(line1)
            elif re.match('(d|D)olphins \^', line):
                line2 = re.sub("(vbz)|(np)", "nns", line)
                output_file.write(line2)
            elif re.match('needta', line):
                line3 =re.sub("nn\+\+\+\?\?\+", '^vb++pmd"++', line)
                output_file.write(line3)
            else:
                output_file.write(line)