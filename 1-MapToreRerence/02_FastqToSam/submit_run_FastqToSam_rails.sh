#! /bin/bash
#$ -wd /u/home/d/dechavez/project-rwayne/rails.project
#$ -l highp,h_rt=02:00:00,h_data=1G
#$ -N subfq2sam
#$ -o /u/scratch/d/dechavez/readsRailsFulgent/log/FastqToSam
#$ -e /u/scratch/d/dechavez/readsRailsFulgent/log/FastqToSam
#$ -m abe
#$ -M dechavezv

#highmem

#usage [dir] [read_1] [read_2] [outfile] [RG] [sample] [library] [flowcell] [seq center]

#QSUB=/u/systems/UGE8.0.1vm/bin/lx-amd64/qsub
QSUB=/u/systems/UGE8.6.4/bin/lx-amd64/qsub
SCRIPT=/u/home/d/dechavez/project-rwayne/2nd.paper/1-MapToreRerence/02_FastqToSam/run_FastqToSam_rails.sh

DIR=/u/home/d/dechavez/project-rwayne/rails.project


#sleep 1h
#sleep 5m

## ${QSUB} ${SCRIPT} ${DIR} GR5_S9_L007_R1_001.fastq.gz GR5_S9_L007_R2_001.fastq.gz GR5_S9_HWKG5BBXX_FastqToSam.bam GR5_1a GR5 Lib1 HWKG5BBXX UCLA
## ${QSUB} ${SCRIPT} ${DIR} LS05_S80_L001_R1_001.fastq.gz LS05_S80_L001_R2_001.fastq.gz LS05.FastqToSam.bam LS051a LS05 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS09_S81_L001_R1_001.fastq.gz LS09_S81_L001_R2_001.fastq.gz LS09.FastqToSam.bam LS091a LS09 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS21_S82_L001_R1_001.fastq.gz LS21_S82_L001_R2_001.fastq.gz LS21.FastqToSam.bam LS221a LS21 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS29_S83_L001_R1_001.fastq.gz LS29_S83_L001_R2_001.fastq.gz LS29.FastqToSam.bam LS291a LS29 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS34_S84_L001_R1_001.fastq.gz LS34_S84_L001_R2_001.fastq.gz LS34.FastqToSam.bam LS341a LS34 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS35_S85_L001_R1_001.fastq.gz LS35_S85_L001_R2_001.fastq.gz LS35.FastqToSam.bam LS351a LS35 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS49_S86_L001_R1_001.fastq.gz LS49_S86_L001_R2_001.fastq.gz LS49.FastqToSam.bam LS491a LS49 Lib1 H5THTDSXY UCB_QB3
## ${QSUB} ${SCRIPT} ${DIR} LS57_S87_L001_R1_001.fastq.gz LS57_S87_L001_R2_001.fastq.gz LS57.FastqToSam.bam LS571a LS57 Lib1 H5THTDSXY UCB_QB3

## ${QSUB} ${SCRIPT} ${DIR} SH6391_SA71240_S1_L004_R1_001.fastq.gz SH6391_SA71240_S1_L004_R2_001.fastq.gz LS02.FastqToSam.bam SA71240 LS02 SH6391 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6391_SA71241_S2_L004_R1_001.fastq.gz SH6391_SA71241_S2_L004_R2_001.fastq.gz LS03.FastqToSam.bam SA71241 LS03 SH6391 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6391_SA71242_S3_L004_R1_001.fastq.gz SH6391_SA71242_S3_L004_R2_001.fastq.gz LS06.FastqToSam.bam SA71242 LS06 SH6391 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6391_SA71243_S4_L004_R1_001.fastq.gz SH6391_SA71243_S4_L004_R2_001.fastq.gz LS08.FastqToSam.bam SA71243 LS08 SH6391 HJNN3DSXY_HiSeqX Fulgent
${QSUB} ${SCRIPT} ${DIR} SH6391_SA71244_S5_L004_R1_001.fastq.gz SH6391_SA71244_S5_L004_R2_001.fastq.gz LS10.FastqToSam.bam SA71244 LS10 SH6391 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6391_SA71245_S6_L004_R1_001.fastq.gz SH6391_SA71245_S6_L004_R2_001.fastq.gz LS12.FastqToSam.bam SA71245 LS12 SH6391 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71246_S1_L001_R1_001.fastq.gz SH6392_SA71246_S1_L001_R2_001.fastq.gz LS13.FastqToSam.bam SA71246 LS13 SH6392 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71247_S2_L001_R1_001.fastq.gz SH6392_SA71247_S2_L001_R2_001.fastq.gz LS14.FastqToSam.bam SA71247 LS14 SH6392 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71248_S3_L001_R1_001.fastq.gz SH6392_SA71248_S3_L001_R2_001.fastq.gz LS15.FastqToSam.bam SA71248 LS15 SH6392 HJNN3DSXY_HiSeqX Fulgent

## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71249_S4_L001_R1_001.fastq.gz SH6392_SA71249_S4_L001_R2_001.fastq.gz LS22.FastqToSam.bam SA71249 LS22 SH6392 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71250_S5_L001_R1_001.fastq.gz SH6392_SA71250_S5_L001_R2_001.fastq.gz LS25.FastqToSam.bam SA71250 LS25 SH6392 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6392_SA71251_S6_L001_R1_001.fastq.gz SH6392_SA71251_S6_L001_R2_001.fastq.gz LS26.FastqToSam.bam SA71251 LS26 SH6392 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71252_S7_L002_R1_001.fastq.gz SH6393_SA71252_S7_L002_R2_001.fastq.gz LS27.FastqToSam.bam SA71252 LS27 SH6393 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71253_S8_L002_R1_001.fastq.gz SH6393_SA71253_S8_L002_R2_001.fastq.gz LS28.FastqToSam.bam SA71253 LS28 SH6393 HJNN3DSXY_HiSeqX Fulgent

## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71254_S9_L002_R1_001.fastq.gz SH6393_SA71254_S9_L002_R2_001.fastq.gz LS31.FastqToSam.bam SA71254 LS31 SH6393 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71255_S10_L002_R1_001.fastq.gz SH6393_SA71255_S10_L002_R2_001.fastq.gz LS32.FastqToSam.bam SA71255 LS32 SH6393 HJNN3DSXY_HiSeqX Fulgent


## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71256_S11_L002_R1_001.fastq.gz SH6393_SA71256_S11_L002_R2_001.fastq.gz LS33.FastqToSam.bam SA71256 LS33 SH6393 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6393_SA71257_S12_L002_R1_001.fastq.gz SH6393_SA71257_S12_L002_R2_001.fastq.gz LS36.FastqToSam.bam SA71257 LS36 SH6393 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71258_S13_L003_R1_001.fastq.gz SH6394_SA71258_S13_L003_R2_001.fastq.gz LS37.FastqToSam.bam SA71258 LS37 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71259_S14_L003_R1_001.fastq.gz SH6394_SA71259_S14_L003_R2_001.fastq.gz LS38.FastqToSam.bam SA71259 LS38 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71260_S15_L003_R1_001.fastq.gz SH6394_SA71260_S15_L003_R2_001.fastq.gz LS39.FastqToSam.bam SA71260 LS39 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71261_S16_L003_R1_001.fastq.gz SH6394_SA71261_S16_L003_R2_001.fastq.gz LS40.FastqToSam.bam SA71261 LS40 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71262_S17_L003_R1_001.fastq.gz SH6394_SA71262_S17_L003_R2_001.fastq.gz LS43.FastqToSam.bam SA71262 LS43 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6394_SA71263_S18_L003_R1_001.fastq.gz SH6394_SA71263_S18_L003_R2_001.fastq.gz LS44.FastqToSam.bam SA71263 LS44 SH6394 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71264_S19_L004_R1_001.fastq.gz SH6395_SA71264_S19_L004_R2_001.fastq.gz LS50.FastqToSam.bam SA71264 LS50 SH6395 HJNN3DSXY_HiSeqX Fulgent

## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71265_S20_L004_R1_001.fastq.gz SH6395_SA71265_S20_L004_R2_001.fastq.gz LS51.FastqToSam.bam SA71265 LS51 SH6395 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71266_S21_L004_R1_001.fastq.gz SH6395_SA71266_S21_L004_R2_001.fastq.gz LS52.FastqToSam.bam SA71266 LS52 SH6395 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71267_S22_L004_R1_001.fastq.gz SH6395_SA71267_S22_L004_R2_001.fastq.gz LS55.FastqToSam.bam SA71267 LS55 SH6395 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71268_S23_L004_R1_001.fastq.gz SH6395_SA71268_S23_L004_R2_001.fastq.gz LS56.FastqToSam.bam SA71268 LS56 SH6395 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71269_S24_L004_R1_001.fastq.gz SH6395_SA71269_S24_L004_R2_001.fastq.gz LS58.FastqToSam.bam SA71269 LS58 SH6395 HJNN3DSXY_HiSeqX Fulgent
## ${QSUB} ${SCRIPT} ${DIR} SH6395_SA71270_S25_L004_R1_001.fastq.gz SH6395_SA71270_S25_L004_R2_001.fastq.gz LS60.FastqToSam.bam SA71270 LS60 SH6395 HJNN3DSXY_HiSeqX Fulgent

