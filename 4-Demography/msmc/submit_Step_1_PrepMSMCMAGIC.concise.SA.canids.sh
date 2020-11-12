#! /bin/bash

#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N SUBmsmsc
#$ -o /u/scratch/d/dechavez/SA.VCF/log/
#$ -e /u/scratch/d/dechavez/SA.VCF/log/
#$ -m abe
#$ -M dechavezv


SCRIPT_DIR=/u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/msmc
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub

cd /u/home/d/dechavez/project-rwayne/SA.VCF/onlyPass

#for line in $(cat /u/home/d/dechavez/project-rwayne/2nd.paper/4-Demography/msmc/list.sp.msmc.Het.txt); do (echo $line && \
## ${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh ${line});done

${QSUB} -N OnlyPassVCF $SCRIPT_DIR/Step_1_PrepMSMCMAGIC.concise.SA.canids.sh bCth
