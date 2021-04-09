#!/bin/bash

#$ -l h_data=1G,h_vmem=10G,h_rt=01:00:00
#$ -wd /u/scratch/d/dechavez/rails.project/Delet
#$ -N subDeletVar_Step1
#$ -o /u/scratch/d/dechavez/rails.project/Delet/log/
#$ -e /u/scratch/d/dechavez/rails.project/Delet/log/
#$ -m abe
#$ -M dechavezv

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/DeltVariation
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

for line in $(cat ${SCRIPT}/list.muta.txt); do \
${QSUB} ${SCRIPT}/run_SubsetVCF_getAlleleGenotCounts.sh ${line}; done
