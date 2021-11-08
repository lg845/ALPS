#This script counts 0cc (hmm that...) and prints the number of 0ccs per text file

#Load packages
import os
import glob
from shutil import copyfile
import re

#open output files
occ_out = open("occ_count.csv", "w+")
occ_out.write("file, occ_count, occ_norm, \n")

#starts 0cc count
occ_count = 0


for file in glob.glob("path/path/*.txt"):
    with open(file, encoding='utf-8', errors='ignore') as file_in:
        occ_out.write(os.path.basename(file))
        for lines in file_in:
            lines = re.sub ("\n", "", lines)
            if re.search("\+", lines):
                elements = lines.split (" ^")
                word = elements[0]
                tag = elements[-1]
                if re.search("0cc", tag):
                    print(tag)
                    occ_count += 1

        occ_out.write("," + str(occ_count) + "," + "\n")
        occ_count = 0
