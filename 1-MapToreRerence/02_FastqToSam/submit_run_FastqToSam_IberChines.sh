#! /bin/bash

#$ -wd /u/scratch/d/dechavez/IberianChinese
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/IberianChinese/log/FastqToSam
#$ -e /u/scratch/d/dechavez/IberianChinese/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_IberChines.sh

DIR=/u/scratch/d/dechavez/IberianChinese


### ${QSUB} ${SCRIPT} ${DIR} bcbr370_S10_R1_001.fastq.gz bcbr370_S10_R2_001.fastq.gz bcbr370_FastqToSam.bam bcbr370 Cbr370 Lib1 H5FTWDSXY UB_QB3

${QSUB} ${SCRIPT} ${DIR} 120325_I244_FCD0RADACXX_L5_SZAIPI007186-13_1.fq.gz 120325_I244_FCD0RADACXX_L5_SZAIPI007186-13_2.fq.gz IbeWIB98_L5_FastqToSam.bam IbeWIB98_L5 IbeWIB98 Lib1 FCD0RADACXX BGI
${QSUB} ${SCRIPT} ${DIR} 120404_I248_FCD0R8DACXX_L5_SZAIPI007186-13_1.fq.gz 120404_I248_FCD0R8DACXX_L5_SZAIPI007186-13_2.fq.gz IbeWIB98_L6_FastqToSam.bam IbeWIB98_L6 IbeWIB98 Lib1 FCD0RADACXX BGI
${QSUB} ${SCRIPT} ${DIR} 120812_I595_FCC0YL0ACXX_L8_SZAXPI012812-26_1.fq.gz 120812_I595_FCC0YL0ACXX_L8_SZAXPI012812-26_2.fq.gz ChXJ30_L8_FastqToSam.bam ChXJ30_L8 ChXJ30 Lib1 FCC0YL0ACXX BGI
${QSUB} ${SCRIPT} ${DIR} 120822_I631_FCC1469ACXX_L5_SZAXPI012812-26_1.fq.gz 120822_I631_FCC1469ACXX_L5_SZAXPI012812-26_2.fq.gz ChXJ30_L5_FastqToSam.bam ChXJ30_L5 ChXJ30 Lib1 FCC0YL0ACXX BGI

