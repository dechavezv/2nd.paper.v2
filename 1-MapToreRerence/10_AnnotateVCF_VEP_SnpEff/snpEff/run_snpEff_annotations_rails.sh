#! /bin/bash
#$ -wd /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf
#$ -l h_rt=65:00:00,h_data=20G,h_vmem=54G,highp
#$ -N RunSnpEffRails
#$ -o /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/log/
#$ -e /u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/log/
#$ -m abe
#$ -t 1-8:1

source /u/local/Modules/default/init/modules.sh
module load java

IDX=$(printf %02d $SGE_TASK_ID)


################################################################################

### Set variables

SNPEFFDIR=/u/home/d/dechavez/project-rwayne/snpEff
REF=AtlantScaf
WORKDIR=/u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf/snpEff/${REF}
VCF=/u/scratch/d/dechavez/rails.project/VCF/Indv/Scaf
Database=Atro.0055

mkdir -p ${WORKDIR}

IDX=$(printf %02d ${SGE_TASK_ID}) # this is SGE specific array id, essentially the contig list 

################################################################################################3
### logging 

cd ${WORKDIR}

# starts logging 
LOGDIR=${WORKDIR}/logs/annotation
mkdir -p ${LOGDIR}
PROGRESSLOG=./logs/progress_${REF}.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}
echo -e "[$(date "+%Y-%m-%d %T")] snpEff annotations based on ${Database} ... " >> ${PROGRESSLOG}

LOG=${LOGDIR}/rails_snpEff_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}

################################################################################

### snpEFF annotations
cd ${SNPEFFDIR}
java -Xmx20g -jar snpEff.jar -nodownload -v -canon -stats ${LOGDIR}/${REF}_chr${IDX}.html \
${Database} \
${VCF}/Reheader_${IDX}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.vcf.gz > \
${VCF}/Reheader_${IDX}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.snpEff.vcf 2> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}
 
cd ${VCF}
# gzip the files 
/u/home/d/dechavez/tabix-0.2.6/bgzip Reheader_${IDX}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.snpEff.vcf
/u/home/d/dechavez/tabix-0.2.6/tabix -p vcf Reheader_${IDX}_FastqToSam.bam_Aligned.MarkDup_Filtered_Masked.snpEff.vcf.gz
