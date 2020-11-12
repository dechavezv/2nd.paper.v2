#! /bin/bash

#$ -cwd
#$ -l h_rt=24:00:00,h_data=1G,h_vmem=30G
#$ -N runROHstep2
#$ -o /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520/log/
#$ -e /u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520/log/
#$ -m abe
#$ -M dechavezv
## #$ -t 1-35

#highmem_forced=TRUE

source /u/local/Modules/default/init/modules.sh
module load vcftools
module load plink

wd=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/20200520

#keep this to solve memeory issues in SCRATH
wd2=/u/scratch/d/dechavez/rails.project/VCF/

#cd ${wd}/plinkInputFiles

plinkoutdir=${wd2}/plinkOutputFiles
#mkdir -p ${plinkoutdir}

# need to get chr name from file
#i=$(printf "$SGE_TASK_ID")
Sample=$1

#FILE=${Sample}.${i}.HQsites.Only.rmDotGenotypes.rmBadVars.Plink
OUTDIR=${plinkoutdir}/plinkroh_${2}_${3}_${4}_${5}_${6}_${7}_${8}

### mkdir -p ${OUTDIR}

### plink --keep-allele-order --file ${FILE} \
### --homozyg \
### --allow-extra-chr \
### --homozyg-kb 100 \
### --homozyg-snp ${2} \
### --homozyg-density ${3} \
### --homozyg-gap ${4} \
### --homozyg-window-snp ${5} \
### --homozyg-window-het ${6} \
### --homozyg-window-missing ${7} \
### --homozyg-window-threshold ${8} \
### --out ${OUTDIR}/${FILE}.out

cd ${OUTDIR}
#rm *summary

#mkdir -p catted

#testing_povide name of sample
#head -n1 LS01.10.HQsites.Only.rmDotGenotypes.rmBadVars.Plink.out.hom  > catted/rails.catted.hom
#cat *.hom |  grep -v "FID"  >>  catted/rails.catted.hom

cd catted/

source /u/local/Modules/default/init/modules.sh
module load R

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/ROH/plot_ROHStep2.rails.R

Rscript ${SCRIPT} plinkroh_${2}_${3}_${4}_${5}_${6}_${7}_${8}

## R CMD BATCH --no-save --no-restore '--args 'plinkroh_${2}_${3}_${4}_${5}_${6}_${7}_${8}' '${SCRIPT}
