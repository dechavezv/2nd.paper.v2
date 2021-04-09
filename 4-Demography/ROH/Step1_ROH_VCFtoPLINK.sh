#! /bin/bash

#$ -cwd
#$ -l h_rt=04:00:00,h_data=10G,highp,h_vmem=30G
#$ -N plinkROH
#$ -o /u/scratch/d/dechavez/L.griseus.Psomangen/20022021/log/
#$ -e /u/scratch/d/dechavez/L.griseus.Psomangen/20022021/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-38

# highmem 

# vcftools LROH requires >1 individual
# plink doesn't

source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

# need to get chr name from file
i=$(printf "%02d" "$SGE_TASK_ID")
#Sample=${1}
wd=/u/scratch/d/dechavez/L.griseus.Psomangen/20022021
vcf=SA.2021.gris.chr${i}_TrimAlt_Annot_Mask_Filter_passingSNPs.vcf.gz

# convert to ped/map format. note that you lose chromosome info - that's a pain.
plinkindir=$wd/plinkInputFiles
plinkoutdir=$wd/plinkOutputFiles
mkdir -p $plinkindir

vcftools --gzvcf $vcf --plink --chr chr$i --out $plinkindir/SA.2021.gris.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
#vcftools --gzvcf $vcf --plink --chr chr$i --out $plinkindir/${Sample%.txt}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
