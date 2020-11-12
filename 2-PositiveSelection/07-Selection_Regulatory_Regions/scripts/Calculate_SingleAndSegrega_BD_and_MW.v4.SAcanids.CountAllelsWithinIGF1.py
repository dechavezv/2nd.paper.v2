"""
Usage:
python ../scripts/Calculate_Singletones_BD_and_MW.py chr_all_filtered.vcf.gz 1800 2800 chr01  > outfile.txt

"""
from random import randint
import random
import sys
import pysam
import os
import gzip
import numpy
import itertools
try:
    import cPickle as pickle
except:
    import pickle
from decimal import *
getcontext().prec = 8

filename = sys.argv[1]
VCF = gzip.open(filename, 'r')

if not os.path.exists("%s.tbi" % sys.argv[1]):
    pysam.tabix_index(sys.argv[1], preset="vcf")
parsevcf = pysam.Tabixfile(sys.argv[1])

samples=[]
for line in VCF:
    if line.startswith('##'):
        pass
    else:
	for i in line.split()[9:]: samples.append(i)
        break
nindiv=len(samples)

start_pos = int(sys.argv[2])
end_pos = int(sys.argv[3])
chromo = sys.argv[4]
EnsemblID = sys.argv[5]
chromo_size={'chr01':122678785,'chr02':85426708,'chr03':91889043,'chr04':88276631,'chr05':88915250,'chr06':77573801,'chr07':80974532,'chr08':74330416,'chr09':61074082,'chr10':69331447,'chr11':74389097,'chr12':72498081,'chr13':63241923,'chr14':60966679,'chr15':64190966,'chr16':59632846,'chr17':64289059,'chr18':55844845,'chr19':53741614,'chr20':58134056,'chr21':50858623,'chr22':61439934,'chr23':52294480,'chr24':47698779,'chr25':51628933,'chr26':38964690,'chr27':45876710,'chr28':41182112,'chr29':41845238,'chr30':40214260,'chr31':39895921,'chr32':38810281,'chr33':31377067,'chr34':42124431,'chr35':26524999,'chr36':30810995,'chr37':30902991,'chr38':23914537,'chrX':123869142}

def checkmono(lst):
    return not lst or lst.count(lst[0]) == len(lst)
BD_single = []
MW_single = []
Missing=[]


nocalls=[0]*len(samples)
calls=[0]*len(samples)
SegregationSites=[0]*len(samples)

sites_present,sites_passing=0,0
for line in parsevcf.fetch(chromo,start_pos,end_pos):
	line = line.split('\t')
	sites_present+=1
	# Get Singletones bush dog
	if ('FAIL' in line[6]): continue
	sites_passing+=1
	
	#Account for missingness
	missing=0
	#for i in range(0,len(samples)):
	for i in range(3,4):
		GT=line[i+9]
		if GT[:3]=='./.': nocalls[i]+=1
		else:
                     	calls[i]+=1
                        if GT[:3]=='0/0': SegregationSites[i]+=0
                        elif GT[:3]=='0/1':
				print(line)
				SegregationSites[i]+=0.5
                        elif GT[:3]=='1/1':
				print(line)
				SegregationSites[i]+=1

output = open(filename + '_SitesIGF1.txt', 'w')

output.write('chromo\tcalls_%s\tSegregationSites_%s\n' % ('\tnocalls_'.join(samples), '\tSegregationSites_'.join(samples)))
output.write('%s\t%s\t%s\n' % (chromo, '\t'.join(map(str,calls)), '\t'.join(map(str,SegregationSites))))
output.close()
VCF.close()

exit()


