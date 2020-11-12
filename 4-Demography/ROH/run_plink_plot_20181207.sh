#! /bin/bash

PLINK=/u/home/j/jarobins/project-rwayne/utils/programs/plink_1.90/plink

cd /u/flashscratch/j/jarobins/vcfs/polymorphic/plink

FILE=IRNP_44_joint_chrALL_polymorphic_SNPs_PASS_plink
OUTDIR=plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}

mkdir -p ${OUTDIR}

${PLINK} --keep-allele-order --autosome-num 38 --bfile ${FILE} \
--homozyg \
--homozyg-kb 100 \
--homozyg-snp ${1} \
--homozyg-density ${2} \
--homozyg-gap ${3} \
--homozyg-window-snp ${4} \
--homozyg-window-het ${5} \
--homozyg-window-missing ${6} \
--homozyg-window-threshold ${7} \
--out ${OUTDIR}/${FILE}

cd ${OUTDIR}

source /u/local/Modules/default/init/modules.sh
module load R

SCRIPT=/u/home/j/jarobins/project-rwayne/utils/scripts/plink_roh/plot_ROH_20181207.R

R CMD BATCH --no-save --no-restore '--args 'plinkroh_${1}_${2}_${3}_${4}_${5}_${6}_${7}' '${SCRIPT}

