#!/bin/bash

#$ -l h_data=5G,h_vmem=10G,h_rt=24:00:00,arch=intel*
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
#$ -N DeletVar_Step1
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -m abe
#$ -M dechavezv
#$ -t 01-38:1

echo '***************** Input Variables ********************************' 
source /u/local/Modules/default/init/modules.sh
module load python/2.7.13 

date=$(date "+%Y-%m-%d")
IDX=$(printf %02d ${SGE_TASK_ID})


SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/DeltVariation/getAlleleGenotCounts.py 
LOG=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/countSitesPerIndividual_${date}.log
OUTDIR=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
VCFDIR=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
Mutt=$1 # list of mutations

VCF=SA.2021.gris.chr${IDX}_TrimAlt_Annot_Mask_Filter_VEP.vcf.gz

#if [ ${Mutt} == 'damaging' ]; then
#    Mutt="frameshift_variant\|splice_acceptor_variant\|splice_donor_variant\|start_lost\|stop_gained\|stop_lost\|deleterious\|inframe_insertion\|inframe_deletion"
#fi

#if [ ${Mutt} == 'benign' ]; then
#    Mutt=""
# fi

Mutts2="splice_region_variant\|stop_retained_variant\|synonymous\|tolerated\|missense"
Mutts="frameshift_variant\|splice_acceptor_variant\|splice_donor_variant\|start_lost\|stop_gained\|stop_lost\|deleterious\|inframe_insertion\|inframe_deletion"
 

#mkdir -p ${OUTDIR}
echo '*****************	Done Inputing Variables	********************************'
 
echo '***************** Subset VCF for mutations Type ********************************'
cd ${VCFDIR}
zcat ${VCF} | head -n 1000 | grep '#' > ${VCF%.vcf.gz}.${Mutt}.vcf
zcat ${VCF} | grep 'protein_coding' | grep ${Mutts2} >> ${VCF%.vcf.gz}.${Mutt}.vcf

#compress
/u/home/d/dechavez/tabix-0.2.6/bgzip ${VCF%.vcf.gz}.${Mutt}.vcf
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${VCF%.vcf.gz}.${Mutt}.vcf.gz

echo '***************** DONE Subsetting VCF for mutations Type ********************************'

cd ${VCFDIR}
echo '***************** Get alles and Genotype counts ********************************'
# first check the overall vcf.gz file 
python ${SCRIPT} --vcf ${VCF%.vcf.gz}.${Mutt}.vcf.gz --outfile ${VCF%.vcf.gz}.${Mutt}.summary.txt --filter ".,PASS"
echo '***************** Done Getting and Genotype counts ********************************'
