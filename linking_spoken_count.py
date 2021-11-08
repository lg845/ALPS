# This script counts the number of spoken advls as per the LGSWE

import os
import glob
from shutil import copyfile
import re
import argparse


nom_out = open("linking_conv.csv", "w+")
nom_out.write("file,conv, \n")


word_count = 0
JJJ_count = 0
JAJ_count = 0
conv_count = 0
ac_count = 0

# Define the way we retrieve arguments sent to the script.
parser = argparse.ArgumentParser(description='tag_fixing')
parser.add_argument('--overwrite', action='store_true')
parser.add_argument('--folder', action="store", dest='dir', default='')
args = parser.parse_args()

for dirpath, dirnames, files in os.walk(args.dir):
    for name in files:
        nom_out.write(name)
        textfile = open(os.path.join(dirpath, name), "r")
        text = textfile.read()
        lines = text.split("\n")

        for i, w in enumerate(lines):
            if re.match("so ", lines[i]):
                if re.search("zz", lines[i-1]) or re.match("uh", lines[i-1]) \
                        or re.match(">", lines[i-1]) or re.match("and", lines[i-1]):
                    conv_count +=1

            if re.match("then", lines[i]):
                conv_count +=1
            if re.match("though$", lines[i]):
                conv_count +=1
            if re.match("anyway", lines[i]):
                conv_count += 1



        nom_out.write("," + str(conv_count) + "\n")
        conv_count = 0
