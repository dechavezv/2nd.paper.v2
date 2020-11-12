#!/bin/bash

#$ -l h_rt=10:00:00,h_data=1G,arch=intel*,h_vmem=8G
#$ -N SelecFlanking
#$ -cwd
#$ -m bea
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/log/
#$ -M dechavezv


# then load your modules:
. /u/local/Modules/default/init/modules.sh
module load bcftools
module load bzip2
module load python

export gVCF=/u/home/d/dechavez/project-rwayne/SA.VCF/Combined
export script=/u/home/d/dechavez/project-rwayne/2nd.paper/2-PositiveSelection/07-Selection_Regulatory_Regions/scripts
export tabix=/u/home/d/dechavez/tabix-0.2.6
export bed=/u/home/d/dechavez/project-rwayne/Besd_Files

grep chr$1 ${bed}/Promoter_All_chr_March10th_2019.txt | while read line; do python -W ignore \
${script}/Calculate_SingleAndSegrega_BD.v4.SAcanids.py ${gVCF}/SA_chr$1_TrimAlt_Annot_Mask_Filter.vcf.gz $line;done \
> /u/scratch/d/dechavez/SingleBySegre/SameFile_SingleBySegreg.BD.v4.July10.2020.chr$1.txt
