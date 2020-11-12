#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=10G,highp,h_vmem=30G
#$ -N plinkROH
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-35

# highmem 

# vcftools LROH requires >1 individual
# plink doesn't

source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

# need to get chr name from file
i=$(printf "$SGE_TASK_ID")

Sample=${1}
wd=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520
vcf=${Sample}_chr${i}_Annot_Mask_Filter_passingSNPs.vcf.gz

cd ${wd}
# convert to ped/map format. note that you lose chromosome info - that's a pain.
plinkindir=$wd/plinkInputFiles
plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkindir

plink --vcf $vcf \
--allow-extra-chr \
--const-fid \
--out ${plinkindir}/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink \
--keep-allele-order \
--recode \
--set-missing-var-ids @-#

## vcftools --gzvcf $vcf --plink --chr PseudoChr_${i} --out $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
