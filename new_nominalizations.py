#this script was used to count nominalizations, focusing on the most productive suffixes in the corpus

import os
import re
import argparse


file_out = open("suffixes_count_updated.csv", "w+")
file_out.write("file, suffixes, \n")


suffixes_count = 0

# Define the way we retrieve arguments sent to the script.
parser = argparse.ArgumentParser(description='derivation script')
parser.add_argument('--overwrite', action='store_true')
parser.add_argument('--folder', action="store", dest='dir', default='')
args = parser.parse_args()

jj = []
for dirpath, dirnames, files in os.walk(args.dir):
    for name in files:
        textfile = open(os.path.join(dirpath, name), "r")
        text = textfile.read()
        text = re.sub("\n\n", " ", text)
        text = text.lower()
        elements = text.split(" ")

        for i, w in enumerate(elements):
            if re.search("\^nn+", elements[i]):
                if re.search("tion$|tions$", elements[i - 1]) or re.search("ity$|ities$", elements[i - 1]) or re.search("ness$", elements[i - 1]) or re.search("isms$|ism$", elements[i - 1]) or re.search("men$t|ments$", elements[i - 1]):
                    if not re.match("motions|questions|section|question|"
                                    "sections|motion|cavity|cavities|city|"
                                    "cities|tradition|nutrition|business|"
                                    "suction|conditions|condition|transactions|"
                                    "solutions|moments|environments|compliments", elements[i - 1]):

                        suffixes_count += 1
                        print(name, suffixes_count)
        file_out.write(name + "," + str(suffixes_count) + "\n")
        suffixes_count = 0

