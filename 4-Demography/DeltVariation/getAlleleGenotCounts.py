# -*- coding: utf-8 -*-
"""
Created on Thu Oct 10 13:34:45 2019
Modified on Sun May 10 21:29:40 2020
@author: annabelbeichman
Modified by Meixi Li
Then Modified by Daniel Aug9 of 2020
"""
import argparse
import gzip

############### Parse input arguments ########################
parser = argparse.ArgumentParser(description='Count number of derived alleles per individual from vcf file.')
parser.add_argument("--vcf",required=True,help="Path to vcf file.")
parser.add_argument("--filter",required=True,help="Site filter to apply. Separate by comma")
## parser.add_argument("--contig",required=True,help="Contig id to append") do not include this for rails. There are ~400k scaffolds. Too many to use this argument
parser.add_argument("--outfile",required=True,help="Path to output file")

args = parser.parse_args()
vcf=str(args.vcf)
outfilename=str(args.outfile)
## contigid = str(args.contig) # do not include this for rails. There are ~400k scaffolds. Too many to use this argument

#### TEST FILE ######### 
# vcf = "JointCalls_testfile.vcf.gz"
# outfilename = "test_call_sites.txt"

#### OPEN A VCF TO READ ######### 
inVCF = gzip.open(vcf, 'r')

#### OPEN A VCF TO WRITE OUT TO ######### 
outfile = open(outfilename, 'w')

expectedGoodGenotypes=['0/0','0|0','0/1','0|1','1/0','1|0','1/1','1|1']
expectedMissingGenotypes=['.','./.']
expectedHomRef=['0/0','0|0']
expectedHomAlt=['1/1','1|1']
expectedHet=['0/1','0|1','1/0','1|0']

#### READ SITE FILTER ######### 
myfilter = str(args.filter).split(',')

########### GET SAMPLE NAMES #############
# get sample names
samples=[]
for line in inVCF:
	if line.startswith('##'):
		pass
	else:
		for i in line.split()[9:]: samples.append(i)
		break

####### set up a dictionary of samples #####
calledSitesPerIndividual = {sample: 0 for sample in samples}
missingSitesPerIndividual = {sample: 0 for sample in samples}
HomRefSitesPerIndividual = {sample: 0 for sample in samples}
HomAltSitesPerIndividual = {sample: 0 for sample in samples}
HetSitesPerIndividual = {sample: 0 for sample in samples}

####### set up a summary count for sites #####
totalSites = 0
passSites = 0
HomAltAllSites = 0

###### READ THROUGH VCF AND EXTRACT INFO LINE BY LINE #######
# first read the header lines ("#") and write out as the new header
inVCF.seek(0)
for line0 in inVCF:
	if line0.startswith('#'):
		continue

	### For all other non-header lines
	line=line0.strip().split('\t') 
	totalSites +=1
	
	# check if pass filter, i.e if the elements in myfilterinfo is a complete subset of myfilter
	# don't split by ";" check the entire string
	myfilterinfo = [line[6]]
	if not set(myfilterinfo).issubset(set(myfilter)):
		continue

	# get all the genotypes for all individuals, then split each individual's genotype info by ":" to get all the calls
	mygenoinfo=line[9:]
	allCalls=[i.split(":")[0] for i in mygenoinfo] # get genotype calls
	# Get the counts of HomozygousREference, Heterozygous and Homozygous Alternate alleles (for now has all combos of genotypes; though if unphased most likely will only see 0/0 0/1 and 1/1)
	# convert to count of derived alleles -- 1/1 = 2; 0/1 = 1; 0/0 = 0 ; ./.=0 
	allCallsDict = dict(zip(samples,allCalls))
	passSites +=1
	# count if all the sites are HomAlt
	if all(gt in expectedHomAlt for gt in allCallsDict.values()):
		HomAltAllSites +=1
	for sample in samples:
		# check if it's missing:
		if allCallsDict[sample] in expectedMissingGenotypes:
		   missingSitesPerIndividual[sample] += 1
		elif allCallsDict[sample] in expectedGoodGenotypes:
			calledSitesPerIndividual[sample] += 1
			# check further in HomRef/HomAlt/Het
			if allCallsDict[sample] in expectedHomRef: 
				HomRefSitesPerIndividual[sample] += 1
			elif allCallsDict[sample] in expectedHomAlt: 
				HomAltSitesPerIndividual[sample] += 1
			elif allCallsDict[sample] in expectedHet: 
				HetSitesPerIndividual[sample] +=1
			else:
				print(allCallsDict[sample])
				print("weird genotypes appearing! beware!!")
		else:
			print(allCallsDict[sample])
			print("weird genotypes appearing! beware!!")

## write out ###
outfile.write("SampleId\tHomRefCount\tHomAltCount\tHomAltAllCount\tHetCount\tCalledCount\tMissingCount\tPassCount\tTotalCount\n")
for sample in samples:
	homref = HomRefSitesPerIndividual[sample]
	homalt = HomAltSitesPerIndividual[sample]
	het = HetSitesPerIndividual[sample]
	call = calledSitesPerIndividual[sample]
	miss = missingSitesPerIndividual[sample]
	outfile.write("\t".join([sample, str(homref), str(homalt), str(HomAltAllSites), str(het), str(call), str(miss), str(passSites), str(totalSites)]))
	outfile.write("\n")
outfile.close()

inVCF.close()
