# Usage: python get_protein_coding_from_table_2019010.py infile.txt

import sys

infile=open(sys.argv[1], 'r')
outfile=open(sys.argv[1][:-4]+'_protein_coding.txt', 'w')


for line0 in infile:
    if line0.startswith("CHR"): outfile.write(line0); continue
    line=line0.strip().split('\t')
    CSQ=line[4].split(',')
    CSQ2=[x for x in CSQ if "|protein_coding|" in x]
    if CSQ2==[]: continue    
    outfile.write('%s\t%s\t%s\n' % ( '\t'.join(line[0:4]), ','.join(CSQ2), '\t'.join(line[5:]) ))
    

outfile.close()
infile.close()

exit()
