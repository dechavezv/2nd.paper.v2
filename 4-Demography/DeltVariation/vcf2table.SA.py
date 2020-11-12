import sys
import gzip

infile=sys.argv[1]

VCF=gzip.open(infile, 'r')
filename=infile[:-7]

samples=[]
for line in VCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

remove=["CL039", "CL149", "CRO1", "ITL1", "JAC1"]

inds=[samples.index(x) for x in samples if x not in remove]
samples=[x for x in samples if x not in remove]

'''
##INFO=<ID=CSQ,Number=.,Type=String,Description="Consequence_annotations_from_Ensembl_VEP._
Format:Allele|Consequence|IMPACT|SYMBOL|Gene|Feature_type|Feature|BIOTYPE|EXON|INTRON|HGVSc|HGVSp|
cDNA_position|CDS_position|Protein_position|Amino_acids|Codons|Existing_variation|
DISTANCE|STRAND|FLAGS|SYMBOL_SOURCE|HGNC_ID|CANONICAL|SIFT">
'''

output=open(filename + "_Table.txt",'w')

output.write('CHR\tPOS\tFILTER\tVAR\tCSQ\t') 
output.write('\t'.join(samples) + '\n')

for line in VCF:
	if line.startswith('#'): continue
	if 'CSQ' not in line: continue 
	#print(line)
	line=line.strip().split('\t')
	INFO=line[7].split(';')
	f=dict(s.split('=') for s in INFO)
	CHR=line[0]
	POS=line[1]
	FILTER=line[6]
	VAR=f['VariantType']
	CSQ=f['CSQ']
	#LROH=[f[x] for x in samples]
	GTs=[0]*len(inds)
	x=0
	for i in inds:
		GT=line[i+9]
		if GT[:3]=='0/0': GTs[x]='0'
		elif GT[:3]=='0|0': GTs[x]='0'
		elif GT[:3]=='0/1': GTs[x]='1'
		elif GT[:3]=='0|1': GTs[x]='1'
		elif GT[:3]=='1/1': GTs[x]='2'
		elif GT[:3]=='1|1': GTs[x]='2'
		else: GTs[x]='NA'
		x+=1
	#output.write('%s\n' % (line))
	output.write('%s\t%s\t%s\t%s\t%s\t'  % (CHR,POS,FILTER,VAR,CSQ) )
	#output.write('%s\t' % '\t'.join(LROH) )
	output.write('%s\n' % '\t'.join(GTs) )

output.close()

VCF.close()

exit()
