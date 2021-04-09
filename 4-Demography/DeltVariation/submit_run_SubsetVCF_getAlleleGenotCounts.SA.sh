#!/bin/bash

#$ -l h_data=1G,h_vmem=10G,h_rt=01:00:00
#$ -wd /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris
#$ -N SAsubDeletVar_Step1
#$ -o /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -e /u/home/d/dechavez/project-rwayne/SA.VCF/Combined/2021.gris/log
#$ -m abe
#$ -M dechavezv

SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/DeltVariation
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

for line in $(cat ${SCRIPT}/list.muta.SA.txt); do \
${QSUB} ${SCRIPT}/run_SubsetVCF_getAlleleGenotCounts.SA.sh ${line}; done
