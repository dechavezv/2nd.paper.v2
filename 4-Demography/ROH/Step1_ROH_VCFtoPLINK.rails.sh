#! /bin/bash

#$ -cwd
#$ -l h_rt=10:00:00,h_data=10G,highp,h_vmem=30G,arch=intel*
#$ -N plinkROH
#$ -o /u/scratch/d/dechavez/rails.project/log/
#$ -e /u/scratch/d/dechavez/rails.project/log/
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

wd=/u/scratch/d/dechavez/rails.project/SNPRelate20200729/ROH
vcfDir=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/Chr_Joint/2021.31Genomes/onlyPass/InvSite
vcf=${vcfDir}/LS_joint_chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.Inva.vcf.gz

cd ${wd}
# convert to ped/map format. note that you lose chromosome info - that's a pain.
plinkindir=$wd/plinkInputFiles
plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkindir

plink --vcf $vcf \
--allow-extra-chr \
--const-fid \
--out ${plinkindir}/LS.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink \
--keep-allele-order \
--recode \
--set-missing-var-ids @-#

## vcftools --gzvcf $vcf --plink --chr PseudoChr_${i} --out $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
