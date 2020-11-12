#! /bin/bash
#$ -wd /u/home/j/jarobins/project-rwayne/irnp/new/snphylo
#$ -l h_rt=02:00:00,h_data=12G
#$ -N snphylo
#$ -o /u/home/j/jarobins/project-rwayne/irnp/SNPRelate
#$ -e /u/home/j/jarobins/project-rwayne/irnp/SNPRelate
#$ -m abe
#$ -M jarobins

SNPHYLO=/u/home/j/jarobins/project-rwayne/utils/programs/snphylo/SNPhylo/snphylo2.sh

cd /u/home/j/jarobins/project-rwayne/irnp/new/snphylo

FILE=IRNP_44_vars_20canids_PASS_polymorphic_autos.gds

${SNPHYLO} -d ${FILE} -l 0.25 -m 0.1 -M 0.1 -b 1000 -a 38 -r -o GFO1
