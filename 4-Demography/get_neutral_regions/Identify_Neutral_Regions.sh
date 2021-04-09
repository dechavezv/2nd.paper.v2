#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/Neutral_regions
#$ -l h_rt=53:00:00,h_data=20G,h_vmem=125G,highp,highmem_forced=TRUE
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/Neutral_regions/log/Neutral_sites.out.txt
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/Neutral_regions/log/Neutral_sites.err.txt
#$ -pe shared 4
#$ -m abe

# Identifies and extract high quality putatively neutral regions (10Kb away from exons, among other requierements)
# Author: Annabel Beichman
# Adapted by Meixi & Sergio for use on fin whale project 
# Usage: ./Identify_Neutral_Regions.sh [user] [reference species]

source /u/local/Modules/default/init/modules.sh
module load bedtools
#module load blast

### Set variables

USER=${1}
REF=${2}

HOMEDIR=/u/home/d/dechavez/project-rwayne/rails.project
WORKDIR=${HOMEDIR}/Neutral_regions
ZFISHDIR=/u/project/rwayne/snigenda/finwhale/Other_genomes/zebraFish_genome
BLAST=/u/project/rwayne/software/CAPTURE/ncbi-blast-2.7.1+
mkdir -p ${WORKDIR}
mkdir -p ${ZFISHDIR}

REFDIR=${HOMEDIR}/reference.genomes/InaccesibleRail/chr_and_superScafolds
REFERENCE=${REFDIR}/InaccesibleRail.chr.fa
#GFF=${HOMEDIR}/chicken/Gallus_gallus.GRCg6a.103.chr.gff3.gz
#CDS_REGIONS=${REFDIR}/Merged.Sort.Atlantisia.CDS.PseudoChr.bed
EXONS=${REFDIR}/Merged.Sort.Atlantisia.CDS.PseudoChr.bed
REPEATS_WM=${REFDIR}/Atlantisia_repeats_WM.bed
#REPEATS_RM=${REFDIR}/GCF_000493695.1_BalAcu1.0_rm.out.bed
CPG_REGIONS=${REFDIR}/bed/InaccesibleRail.chr_cpgIslands.bed
#CPG_REPEATS=${REFDIR}/bed/CpG_repeats.bed
    

# script to get gc content
getGC=/u/project/rwayne/snigenda/finwhale/scripts/Other/get_gc_content.pl

### Describing filtering steps:

# 1. >10kb from exons
# 2. not inside CpG Island
# 3. not inside repeat region
# 4. normal GC content
# 5. doesn't blast to zebra fish


### Get exonic regions (do only once) and make sure is sorted

#awk '$3=="exon"' ${GFF} | awk '{OFS="\t";print $1,$4-1,$5,$9}' | sort -k1,1 -k2,2n | perl -pe 's/^(\w+\t)/PseudoChr_\1/g' | grep -v > ${EXONS}
#zcat ${GFF} | awk '$3=="exon"' | awk '{OFS="\t";print $1,$4-1,$5,$9}' | sort -k1,1 -k2,2n | perl -pe 's/^(\w+\t)/PseudoChr_\1/g' | grep -v 'PseudoChr_MT'
#awk '$3=="exon"' ${GFF} | awk '{OFS="\t";print $1,$4-1,$5,$9}' | sort -k1,1 -k2,2n > ${EXONS} # (Sergio's approach)
#grep exon $gff | awk '{OFS="\t";print $1,$4-1,$5,$9}' | sort -k1,1 -k2,2n > ${EXONS} # (Annabel's approach)
## There are discrepancies between the two methods, Annabel's approach results in 499895 lines, while mine has 499380 lines.
## I ended up using mine because it seems more specific to the column were the features are defined in gff files.


### Defining high quality (HQ) site coordinates 

# results of filtering snps (all populations; all nv and snps)
#######@@@@@@ hqSites=${WORKDIR}/HiQualCoords/all_HQCoords_sorted_merged.bed # bed coords (sorted, merged) of sites from previous selection of high quality coordinates (comes from the output of the script "GetHiQualCoords_20200602.sh")


### Get distance of every set of sites from exonic regions in Minke whale's genome

# make directories were this information will be stored

mkdir -p ${WORKDIR}/DistanceFromExons # This directory will have info on distance of sites from exons
mkdir -p ${WORKDIR}/CpG_Islands
mkdir -p ${WORKDIR}/repeatRegions
mkdir -p ${WORKDIR}/get_fasta
mkdir -p ${WORKDIR}/GC_Content
mkdir -p ${WORKDIR}/zebra_fish
mkdir -p ${WORKDIR}/HQ_neutral_sites # This directory will have neutral regions going through 3 checks: CpG Islands, repetitive regions, and do not blast to fish

# Getting the distance

########### bedtools closest -d -a ${hqSites} -b ${EXONS} > ${WORKDIR}/DistanceFromExons/all_HQCoords_DistFromExons.0based.txt

#run this if you get erros in the all_HQCoords_DistFromExons.0based.txt file:
#perl -pe 's/^2\n//;s/^8\n//g' all_HQCoords_sorted_merged.bed > Edited.all_HQCoords_sorted_merged.bed
#rm all_HQCoords_sorted_merged.bed; mv Edited.all_HQCoords_sorted_merged.bed all_HQCoords_sorted_merged.bed
#cat all_HQCoords_sorted_merged.bed | sort -k1,1 -k2,2n | uniq > Edited.all_HQCoords_sorted_merged.bed
#rm all_HQCoords_sorted_merged.bed; mv Edited.all_HQCoords_sorted_merged.bed all_HQCoords_sorted_merged.bed

# NOTE: the output of the above command will be in 8 columns:
# [HQ site info (first 3 columns)] [closest exon info (columns 4 to 7] [distance between (column 8)]; so I want the HQ sites that are >10000bp away from the closest exon.
# Don't want it the other way around (getting info on each exon). I Want info on HQ sites. It is important to keep in mind what is entered into a and b in bedtools. 

# Exploring and choosing different distances

# The last column (8) is the distance; I want it to be at least 10,000, and want to keep track of the distance. Collect all that are >10,000 away.
# Pick the ones with specific distance (awk) from exons, we tried 3 different distances: 10Kb, 20Kb, 50Kb.
#######@@@@@@ awk -F'\t' '{OFS="\t";if($7>10000)print $1,$2,$3}' ${WORKDIR}/DistanceFromExons/all_HQCoords_DistFromExons.0based.txt |  sort -k1,1 -k2,2n | bedtools merge -i stdin > ${WORKDIR}/DistanceFromExons/all_HQCoords_min10kb_DistFromExons.0based.bed
#######@@@@@@ awk -F'\t' '{OFS="\t";if($7>5000)print $1,$2,$3}' ${WORKDIR}/DistanceFromExons/all_HQCoords_DistFromExons.0based.txt |  sort -k1,1 -k2,2n | bedtools merge -i stdin > ${WORKDIR}/DistanceFromExons/all_HQCoords_min5kb_DistFromExons.0based.bed
#######@@@@@@ awk -F'\t' '{OFS="\t";if($7>1000)print $1,$2,$3}' ${WORKDIR}/DistanceFromExons/all_HQCoords_DistFromExons.0based.txt |  sort -k1,1 -k2,2n | bedtools merge -i stdin > ${WORKDIR}/DistanceFromExons/all_HQCoords_min1kb_DistFromExons.0based.bed
# Note: 1,2,3 columns are the HQ SITES position, NOT the position of the exon. (If you mess up what is a and b in bedtools closest this would be messed up)


### Get total amounts of sequence in each file:

#######@@@@@@ > ${WORKDIR}/totalSequenceByDistanceFromExons.txt
#######@@@@@@ for i in `ls ${WORKDIR}/DistanceFromExons/*bed`
#######@@@@@@ do
#######@@@@@@ echo $i >> ${WORKDIR}/totalSequenceByDistanceFromExons.txt
#######@@@@@@ awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' $i >> ${WORKDIR}/totalSequenceByDistanceFromExons.txt
#######@@@@@@ done


### We decided to use the bed file with sites at least 10kb from exons to be further filtered and to make the neutral SFS


######### Check neutral regions (10kb) #########

### Check if regions intersect with CpG Islands

# got CpG islands from UCSC browser; do intersection and get regions that DO NOT intersect with CpG islands. In the case of the fin whale files, the result of this should not give any intersections since we already filter for CpG islands in the filtering step WGSproc8, all CpG islands or repetitive regions were flag as "FAIL_CpGRep". Therefore, only sites with flag PASS should have been included in the HQ coordinates file.
# The option -v in bedtools intersect will output regions in "A" that ***DO NOT*** intersect with "B" (CpG Islands)
#######@@@@@@ bedtools intersect -v -a ${WORKDIR}/DistanceFromExons/all_HQCoords_min10kb_DistFromExons.0based.bed -b ${CPG_REGIONS} > ${WORKDIR}/CpG_Islands/all_HQCoords_min10kb_DistFromExons_noCpGIsland.bed


### Check if regions intersect with repetitive regions. We intersected with two different files containing repetitive regions, one generated using WindowMasker and the other by RepeatMasker. 

# the first step intersects the HQ sites with the WindowMasker file. This intersection should be zero since we already filtered for the repetitive regions on this file during the filtering step WGSproc8, in which they were flag as "FAIL_CpGRep" together with the CpG islands.
# for the second intersection, we got the repetitive sites extracted by the RepeatMasker software from the NCBI data; do intersection and get regions that DO NOT intersect repetitive regions. In this case we should get some intersection since we have not used the RepeatMasker sites for filtering.
#######@@@@@@ bedtools intersect -v -a ${WORKDIR}/CpG_Islands/all_HQCoords_min10kb_DistFromExons_noCpGIsland.bed -b ${REPEATS_WM} > ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeatWM.bed
#bedtools intersect -v -a ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeatWM.bed -b ${REPEATS_RM} > ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat.bed
# check amount  of sequence lost:
# awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat.bed


### Re-merge the bed file with -d 10 setting (if things are 10bp apart you can still merge them)

# use this to get fasta
# doing this because if there is a single isolated base,
# it becomes its own entry in the fasta, which is going to make BLASTING a pain
# for now looking at overall region (allowing gaps of up to 10bp), not just called sites.
#######@@@@@@ bedtools merge -d 10 -i ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeatWM.bed > ${WORKDIR}/get_fasta/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat_mergedMaxDistance10.forFasta.notForSFS.bed


### Get fasta sequences

#######@@@@@@ bedtools getfasta -fi ${REFERENCE} -bed ${WORKDIR}/get_fasta/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat_mergedMaxDistance10.forFasta.notForSFS.bed -fo ${WORKDIR}/get_fasta/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat.fasta

############# Get GC content of each part of Fasta (exclude if >50%?) ##############

## for now not filtering on this; just generating it for interest.
#######@@@@@@ perl ${getGC} ${WORKDIR}/get_fasta/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat.fasta > ${WORKDIR}/GC_Content/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat_GCcontent.txt
# not going to filter further since I already got rid of CpG islands.

############# Blast against zebra fish genome to look for conservation #############

# do this once (I already downloaded the zebra fish genome and created a data base, so the lines are commented out):
cd ${ZFISHDIR}
#wget ftp://ftp.ensembl.org/pub/release-99/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.toplevel.fa.gz
#gunzip Danio_rerio.GRCz11.dna.toplevel.fa.gz
# ${BLAST}/bin/makeblastdb -in Danio_rerio.GRCz11.dna.toplevel.fa -out Dare_blastdb -dbtype nucl
#######@@@@@@ ${BLAST}/bin/blastn -query ${WORKDIR}/get_fasta/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat.fasta -db ${ZFISHDIR}/Dare_blastdb -outfmt 7 -num_threads 4 > ${WORKDIR}/zebra_fish/neutralRegions_Blast_ZebraFish_blastn.out
# based on output, get regions with e-value < 1e-10 to exclude. You are getting their coordinates from their fasta name, not from the blast output
# so it is still 0-based even though blast output is 1-based.

cd ${WORKDIR}/zebra_fish
#######@@@@@@ grep -v "#"  ${WORKDIR}/zebra_fish/neutralRegions_Blast_ZebraFish_blastn.out | awk '{if($11<1e-10)print $1}' | awk -F"[:-]" '{OFS="\t"; print $1,$2,$3}' | sort | uniq > ${WORKDIR}/zebra_fish/fish.matches.eval.1e-10.0based.bed
# then want to exclude those
bedtools intersect -v -a ${WORKDIR}/repeatRegions/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeatWM.bed -b ${WORKDIR}/zebra_fish/fish.matches.eval.1e-10.0based.bed > ${WORKDIR}/zebra_fish/all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat_noMappedFish.bed

# can then use the final bed file to make the SFS using Tanya's script.
finalBedDir=${WORKDIR}/zebra_fish
finalBed=all_HQCoords_min10kb_DistFromExons_noCpGIsland_noRepeat_noMappedFish.bed
cp ${finalBedDir}/${finalBed} ${WORKDIR}/HQ_neutral_sites

cd ${WORKDIR}/HQ_neutral_sites
cp ${finalBed} Final_HQ_neutral_regions.bed

#The final bed file with HQ neutral regions is in the directory HQ_Neutral_Sites
# you can choose which of the sets of filters you want and update this accordingly. For now it is the file that has regions:
# 10kb from exons
# not in CpG island
# not in repeat region
# does not blast to zebra fish
# no other GC content filter

# get final amount of sequence:
awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}' ${WORKDIR}/HQ_neutral_sites/Final_HQ_neutral_regions.bed > ${WORKDIR}/HQ_neutral_sites/totalPassingSequence.txt
