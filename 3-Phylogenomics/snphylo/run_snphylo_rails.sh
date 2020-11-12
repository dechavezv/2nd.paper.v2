#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project/VCF
#$ -l h_rt=02:00:00,h_data=12G,highp
#$ -N snphylo
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/log/
#$ -m abe
#$ -M dechavezv

SNPHYLO=/u/home/d/dechavez/project-rwayne/snphylo/SNPhylo/snphylo2.sh
FILE=Reheader_allchr_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.gds

## source /u/local/Modules/default/init/modules.sh
## module load R/3.4.0

cd /u/home/d/dechavez/project-rwayne/rails.project/VCF

${SNPHYLO} -d ${FILE} -l 0.25 -m 0.1 -M 0.1 -b 1000 -r
### ${SNPHYLO} -d ${FILE} -l 0.25 -m 0.1 -M 0.1 -b 1000 -a 38 -r -o GFO1
