#! /bin/bash

#$ -wd /u/scratch/d/dechavez/readsRailsFulgent
#$ -l highp,h_rt=4:00:00,h_data=1G
#$ -N subAlign
#$ -o /u/scratch/d/dechavez/readsRailsFulgent/log/BWA
#$ -e /u/scratch/d/dechavez/readsRailsFulgent/log/BWA
#$ -m abe
#$ -M dechavezv

QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPTDIR=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/04_AlignCleanBam

cd /u/home/d/dechavez/project-rwayne/rails.project/

## for i in *MarkIlluminaAdapters.bam; do
#	FILENAME=${i%_MarkIlluminaAdapters.bam}
#	$QSUB $SCRIPTDIR/run_AlignCleanBam_rails.sh ${FILENAME}
	#sleep 3h
#done

$QSUB $SCRIPTDIR/run_AlignCleanBam_rails.sh LS13.FastqToSam.bam 
$QSUB $SCRIPTDIR/run_AlignCleanBam_rails.sh LS10.FastqToSam.bam
