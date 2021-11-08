#counts the number of jj, adv and nn types in each file
import os
import re
import argparse


# Define the way we retrieve arguments sent to the script.
parser = argparse.ArgumentParser(description='types_per_text')
parser.add_argument('--overwrite', action='store_true')
parser.add_argument('--folder', action="store", dest='dir', default='')
args = parser.parse_args()


#initalize counts
file_count = 0

jj = []
vb = []
nn = []

file_out = open("types_by_text_written.csv", "w+")
file_out.write(str("filename, nn, vb, adj" + "\n"))

for dirpath, dirnames, files in os.walk(args.dir):
    for name in files:
        file_out.write(name)


        textfile = open(os.path.join(dirpath, name), "r")
        text = textfile.read()
        text = text.lower()
        text = re.sub("\r", " ", text)
        text = re.sub("\n", "", text)
        elements = text.split(" ^")
        elements = text.split(" ")

        for i, w in enumerate(elements):
            if re.findall("\^jj", elements[i]):
                attributive = elements[i - 1]
                jj.append(attributive)
                jj = list(set(jj))
            elif re.findall("\^v", elements[i]):
                verb = elements[i - 1]
                vb.append(verb)
                vb = list(set(vb))
            elif re.findall("\^n", elements[i]):
                noun = elements[i - 1]
                nn.append(noun)
                nn = list(set(nn))
        file_out.write("," + str(len(nn)) + "," + str(len(vb)) + "," + str(len(jj)) +"\n")
        jj = []
        nn = []
        vb = []




