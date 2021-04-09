#! /bin/bash

#$ -cwd
#$ -l h_rt=30:00:00,h_data=4G,highp,h_vmem=80G
#$ -N msmc
#$ -pe shared 11
#$ -o /u/scratch/d/dechavez/L.griseus.Psomangen/log/
#$ -e /u/scratch/d/dechavez/L.griseus.Psomangen/log/
#$ -m abe
#$ -M dechavezv

# run MSMC with default settings (for now)

source /u/local/Modules/default/init/modules.sh
module load python/3.4 ## has to be 3.6! otherwise won't work.
msmc_tools=/u/home/d/dechavez/msmc-tools
msmc=/u/home/d/dechavez/msmc-master/msmc

rundate=`date +%Y%m%d` # msmc rundate

PREFIX=$1

date=20022021 #Input creation date

INPUTDIR=/u/scratch/d/dechavez/L.griseus.Psomangen/${date}/msmcAnalysis/inputFiles
OUTDIR=/u/scratch/d/dechavez/L.griseus.Psomangen/${date}/msmcAnalysis/output_${rundate}
mkdir -p $OUTDIR

${msmc} -t 11 -o $OUTDIR/rails.msmc.${PREFIX}.out $INPUTDIR/chunk_${PREFIX}_*_postMultiHetSep.txt

# use the following if you get an index error message
## -I 0,1
