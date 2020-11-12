#! /bin/bash
#$ -wd /u/project/rwayne/snigenda/finwhale
#$ -l h_rt=05:00:00,h_data=20G,h_vmem=24G
#$ -o /u/project/rwayne/snigenda/finwhale/reports/WGSproc7.out.txt
#$ -e /u/project/rwayne/snigenda/finwhale/reports/WGSproc7.err.txt
#$ -m abe

# Usage: qsub -t 1-96/1-23 snpEff_ann.sh Reference
# Examples: qsub -t 1-96 snpEff_ann.sh Minke/Bryde

source /u/project/rwayne/software/finwhale/miniconda2/etc/profile.d/conda.sh
conda activate gentools

set -o pipefail

################################################################################

### Set variables

USER=${1}
REF=${2}

BAMHEAD="MarkDuplicates" 
SNPEFFDIR=/u/project/rwayne/software/finwhale/miniconda2/envs/gentools/share/snpeff-4.3.1t-2
HOMEDIR=/u/project/rwayne/snigenda/finwhale
SIRIUSDIR=/data3/finwhale 

WORKDIR=${HOMEDIR}/filteredvcf/all48/${REF}
WORKSIRIDIR=${SIRIUSDIR}/filteredvcf/all48/${REF}

mkdir -p ${WORKDIR}
ssh ${USER}@sirius.eeb.ucla.edu "mkdir -p ${WORKSIRIDIR}" 

IDX=$(printf %02d ${SGE_TASK_ID}) # this is SGE specific array id, essentially the contig list 

# define variables by references 
if [ $REF == 'Minke' ]; then
    Database=Baac01.10776
    num_seqs=96
fi

if [ $REF == 'Bryde' ]; then
    Database=Baed01.141314
    num_seqs=23
fi

################################################################################

### logging 

cd ${WORKDIR}

# starts logging 
LOGDIR=${WORKDIR}/logs/annotation
mkdir -p ${LOGDIR}
PROGRESSLOG=./logs/WGSproc7_${REF}_${BAMHEAD}_${IDX}_progress_all48.log
echo -e "[$(date "+%Y-%m-%d %T")] JOB_ID: ${JOB_ID}" > ${PROGRESSLOG}
echo -e "[$(date "+%Y-%m-%d %T")] snpEff annotations based on ${Database} ... " >> ${PROGRESSLOG}

LOG=${LOGDIR}/04_all48_${REF}_${BAMHEAD}_snpEff_${IDX}.log
date "+%Y-%m-%d %T" > ${LOG}


################################################################################

### snpEFF annotations 

snpEff -Xmx16g -nodownload -v -canon -stats ${LOGDIR}/${REF}_chr${IDX}.html \
${Database} \
JointCalls_06_B_VariantAnnotator_${IDX}.vcf.gz > \
JointCalls_07_snpEff_${IDX}.vcf 2> ${LOG}

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] FAIL" >> ${PROGRESSLOG}
    exit 1
fi
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}
 
# gzip the files 
bgzip JointCalls_07_snpEff_${IDX}.vcf 
tabix -p vcf JointCalls_07_snpEff_${IDX}.vcf.gz

################################################################################

### Move intermediate files to Sirius 

echo -e "[$(date "+%Y-%m-%d %T")] Copying GVCFs files to ${WORKSIRIDIR}... " >> ${PROGRESSLOG}

scp JointCalls_07_snpEff_${IDX}.vcf.gz ${USER}@sirius.eeb.ucla.edu:${WORKSIRIDIR}
exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] Copying JointCalls_07_snpEff_${IDX}.vcf.gz FAIL" >> ${PROGRESSLOG}
    exit 1
fi

scp JointCalls_07_snpEff_${IDX}.vcf.gz.tbi ${USER}@sirius.eeb.ucla.edu:${WORKSIRIDIR}
# rm JointCalls_06_B_VariantAnnotator_${IDX}.vcf.gz
# rm JointCalls_06_B_VariantAnnotator_${IDX}.vcf.gz.tbi

exitVal=${?}
if [ ${exitVal} -ne 0 ]; then
    echo -e "[$(date "+%Y-%m-%d %T")] Copying JointCalls_07_snpEff_${IDX}.vcf.gz.tbi FAIL" >> ${PROGRESSLOG}
    exit 1
fi
echo -e "[$(date "+%Y-%m-%d %T")] Done" >> ${PROGRESSLOG}

conda deactivate 



