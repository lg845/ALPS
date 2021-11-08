import re
import sys
import argparse
import os


# Define the way we retrieve arguments sent to the script.
parser = argparse.ArgumentParser(description='tag_fixing')
parser.add_argument('--overwrite', action='store_true')
parser.add_argument('--folder', action="store", dest='dir', default='')
args = parser.parse_args()

for dirpath, dirnames, files in os.walk(args.dir):
    for name in files:
        # print(name)
        textfile = open(os.path.join(dirpath, name), "r")

        cleaned_filename = re.sub(r'\.\.[\\\/]', r'', name)
        output_directory = 'written'
        output_filename = os.path.join(output_directory, cleaned_filename)
        directory = os.path.dirname(output_filename)
        if not os.path.exists(directory):
            os.makedirs(directory)

        output_file = open(output_filename, 'w')
        text = textfile.read()
        lines = text.split("\n")
        # print(lines)

        for i, w in enumerate(lines):
            # print(w)
            if re.findall("tht\+rel", lines[i]) and re.search("\^uh", lines[i - 1]):
                if re.findall(">", lines[i - 2]) or re.findall("<", lines[i - 3]):
                    lineq = re.sub("tht\+rel", "tht+0cc", lines[i])
                    lineq = re.sub("subj", "", lineq)
                    lineq = re.sub("obj", "", lineq)
                    output_file.write(lineq + "\n")
                elif not re.search("n(n|p|r)(s|u|l)?\+", lines[i - 3]):
                    liner = re.sub("rel", "zrel", lines[i])
                    liner = re.sub("subj", "", liner)
                    liner = re.sub("obj", "", liner)
                    output_file.write(liner + "\n")
                else:
                    output_file.write(w + "\n")
            elif re.findall("tht\+rel", lines[i]) and re.search(">", lines[i - 1]):
                linez = re.sub("tht\+rel", "tht+0cc", lines[i])
                linez = re.sub("subj", "", linez)
                linez = re.sub("obj", "", linez)
                output_file.write(linez + "\n")
            elif re.findall("tht\+vcmp", lines[i]):
                if re.search("cc", lines[i - 1]):
                    linet = re.sub("vcmp", "0cc+", lines[i])
                    output_file.write(linet + "\n")
                if re.search("uh", lines[i - 1]) or re.search("uh", lines[i - 2]):
                    linev = re.sub("vcmp", "0cc+", lines[i])
                    output_file.write(linev + "\n")
                if re.search(">", lines[i - 1]) or re.search(">", lines[i - 2]):
                    linev = re.sub("vcmp", "0cc+", lines[i])
                    output_file.write(linev + "\n")
                else:
                    output_file.write(w + "\n")
            else:
                output_file.write(w + "\n")
