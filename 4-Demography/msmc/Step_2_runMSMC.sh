#! /bin/bash

#$ -cwd
#$ -l h_rt=60:00:00,h_data=4G,highp,h_vmem=20G
#$ -N msmc
#$ -pe shared 11
#$ -o /u/scratch/d/dechavez/rails.project/VCF/msmc/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/msmc/log/
#$ -m abe
#$ -M dechavezv
#$ -t 1-8:1

# run MSMC with default settings (for now)

source /u/local/Modules/default/init/modules.sh
module load python/3.4 ## has to be 3.6! otherwise won't work.
msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

rundate=`date +%Y%m%d` # msmc rundate
date=20200805 #Input creation date

OUTDIR=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/${date}/msmcAnalysis/output_${rundate}
mkdir -p $OUTDIR

INPUTDIR=/u/home/d/dechavez/project-rwayne/rails.project/VCF/DanielData/msmc/${date}/msmcAnalysis/inputFiles

i=$(printf "%02d" $SGE_TASK_ID) # chunk


$msmc -t 11 -I 0,1 -o $OUTDIR/rail.msmc.LS${i}.out $INPUTDIR/chunk_${i}_postMultiHetSep.*.txt

#use t 11 make it faster remeber to change #$ -t as well
# use the following if you get an index error message
## -I 0,1
