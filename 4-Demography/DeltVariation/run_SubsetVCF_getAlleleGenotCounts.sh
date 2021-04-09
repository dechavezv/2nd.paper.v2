#!/bin/bash

#$ -l h_data=4G,h_vmem=10G,h_rt=09:00:00,arch=intel*
#$ -wd /u/scratch/d/dechavez/rails.project/Delet
#$ -N DeletVar_Step1
#$ -o /u/scratch/d/dechavez/rails.project/Delet/log/
#$ -e /u/scratch/d/dechavez/rails.project/Delet/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-35:1

echo '***************** Input Variables ********************************' 
source /u/local/Modules/default/init/modules.sh
module load python

date=$(date "+%Y-%m-%d")

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/DeltVariation/getAlleleGenotCounts.py 
LOG=/u/scratch/d/dechavez/rails.project/Delet/countSitesPerIndividual_${date}.log
OUTDIR=/u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/DeletVat
VCFDIR=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes
Mutt=$1 # list of mutations

IDX=$(printf ${SGE_TASK_ID}) #sample

VCF=LS_joint_chr${IDX}_TrimAlt_Annot_Mask_Filter.vcf.snpEff

if [ $Mutt == 'LOF' ]; then
    $Mutt='start_lost\|stop_gained\|splice_acceptor_variant\|splice_donor_variant'
fi

#mkdir -p ${OUTDIR}
echo '*****************	Done Inputing Variables	********************************'
 
echo '***************** Subset VCF for mutations Type ********************************'
cd ${OUTDIR}
zcat ${VCFDIR}/${VCF}.vcf.gz | grep '#' > ${VCF}.${Mutt}.vcf
zcat ${VCFDIR}/${VCF}.vcf.gz | grep ${Mutt} >> ${VCF}.${Mutt}.vcf 

#compress
/u/home/d/dechavez/tabix-0.2.6/bgzip ${VCF}.${Mutt}.vcf
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf ${VCF}.${Mutt}.vcf.gz
echo '***************** DONE Subsetting VCF for mutations Type ********************************'

echo '***************** Get alles and Genotype counts ********************************'
# first check the overall vcf.gz file 
python ${SCRIPT} --vcf ${VCF}.${Mutt}.vcf.gz --outfile LS${IDX}_sites_summary_${Mutt}.txt --filter ".,PASS"
echo '***************** Done Getting and Genotype counts ********************************'
