#! /bin/bash

#$ -l h_rt=24:00:00,h_data=5G,highp,h_vmem=10G,arch=intel*
#$ -N msmcSAcanid
#$ -cwd
#$ -m bea
#$ -o /u/scratch/d/dechavez/L.griseus.Psomangen/log/
#$ -e /u/scratch/d/dechavez/L.griseus.Psomangen/log/
#$ -M dechavezv
#$ -t 1-38:1

source /u/local/Modules/default/init/modules.sh
module load python
module load perl


msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

# date you called genotypes:
date=20022021
wd=/u/scratch/d/dechavez/L.griseus.Psomangen/${date}
vcfwd=/u/scratch/d/dechavez/L.griseus.Psomangen/GVCFs/onlyPass

PREFIX=$1

i=$(printf %02d $SGE_TASK_ID)


## THE vcf file is already masked for sites outside of coverage range and for genotypes that have a dot (./.), as well as having indels and all sites not passing filters removed

vcf=${vcfwd}/${PREFIX}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz #this has already gone through masking

# PREP FOR MSMC:
mkdir -p ${wd}/msmcAnalysis
mkdir -p ${wd}/msmcAnalysis/inputFiles

/u/home/d/dechavez/project-rwayne/anaconda3/bin/python3 ${msmc_tools}/generate_multihetsep.py ${vcf} > ${wd}/msmcAnalysis/inputFiles/chunk_${PREFIX}_${i}_postMultiHetSep.txt
